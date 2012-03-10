namespace :doc do
  namespace :diagram do
    task :models do
      sh "railroady -i -l -a -m -M | dot -Tpng | sed 's/font-size:14.00/font-size:11.00/g' > doc/models.png"
    end

    task :controllers do
      sh "railroady -i -l -C | neato -Tpng | sed 's/font-size:14.00/font-size:11.00/g' > doc/controllers.png"
    end
  end

  task :diagrams => %w(diagram:models diagram:controllers)
end