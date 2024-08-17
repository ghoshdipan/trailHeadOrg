FROM node

RUN npm install --global sfdx-cli && \
sfdx force --help

RUN echo y |sfdx pluggings:install sfdx-git delta && \
sfdx sgd:source:delta --help

RUN sfdx pluggins:install sfdmu && \
sfdx sfdx:run --help

npm run install