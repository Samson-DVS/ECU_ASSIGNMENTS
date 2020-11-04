cd
sudo apt-get update
sudo apt-get install golang
go get -u github.com/tomnomnom/gf
go get github.com/tomnomnom/waybackurls
go get -u github.com/hahwul/dalfox

cd go/bin/
cp gf /usr/local/bin/
cp waybackurls /usr/local/bin/
cp dalfox /usr/local/bin/

git clone https://github.com/1ndianl33t/Gf-Patterns
mkdir .gf
mv ~/Gf-Patterns/*.json ~/.gf

echo 'Done'

echo 'Sample'
echo '1. echo "http://testphp.vulnweb.com/" | sudo waybackurls | tee target.txt' 
echo '2. cat target.txt | sudo gf xss | sed 's/=.*/=/' | sed 's/URL: //' | tee test.txt'
echo '3. sudodalfox file test.txt pipe'
