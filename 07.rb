class Folder
    attr_accessor :filesize
    attr_reader :parent, :folders
    def initialize(name, parent)
        @name = name
        @parent = parent
        @folders = {}
        @filesize = 0 
    end

    def fullsize
        if @folders == {}
            @filesize
        else
            @filesize + @folders.values.map(&:fullsize).sum
        end
    end

    def addfile(size)
        @filesize += size
    end

    def addfolder(name)
        @folders[name] = Folder.new(name, self) if @folders[name].nil?
        @folders[name]
    end

    def eachchild
        Enumerator.new do |e|        
            @folders.values.each do |f|
                e << f 
                f.eachchild.each do |fc|
                    e << fc
                end
            end
        end
    end
end
input = open('07.txt').read.lines
foldertree = Folder.new("/", nil)
cwd = foldertree

input.each do |line|
    case line
    when /^\$ cd \.\./
        cwd = cwd.parent
    when /^\$ cd (\w+)/
        cwd = cwd.addfolder($1)
    when /^(\d+)/
        cwd.addfile($1.to_i)
    end
end
pp foldertree
puts foldertree.fullsize

p foldertree.eachchild.map(&:fullsize).reject{|s| s > 100000}.sum

space_total = 70000000
update_size = 30000000
space_used = foldertree.fullsize
space_avail = space_total - space_used
space_needed = update_size - space_avail
p foldertree.eachchild.map(&:fullsize).sort.reject{|s| s < space_needed }