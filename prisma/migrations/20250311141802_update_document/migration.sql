/*
  Warnings:

  - You are about to drop the `Document` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Document";

-- CreateTable
CREATE TABLE "Page" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "crawledAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Page_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Term" (
    "id" SERIAL NOT NULL,
    "term" TEXT NOT NULL,
    "totalDocuments" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Term_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentTerm" (
    "pageId" INTEGER NOT NULL,
    "termId" INTEGER NOT NULL,
    "tf" DOUBLE PRECISION NOT NULL,
    "idf" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "DocumentTerm_pkey" PRIMARY KEY ("pageId","termId")
);

-- CreateTable
CREATE TABLE "Synonym" (
    "id" SERIAL NOT NULL,
    "rootTerm" TEXT NOT NULL,
    "synonym" TEXT NOT NULL,

    CONSTRAINT "Synonym_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CrawlHistory" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "startedAt" TIMESTAMP(3) NOT NULL,
    "finishedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CrawlHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SearchQuery" (
    "id" SERIAL NOT NULL,
    "query" TEXT NOT NULL,
    "resultCount" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SearchQuery_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Page_url_key" ON "Page"("url");

-- CreateIndex
CREATE UNIQUE INDEX "Term_term_key" ON "Term"("term");

-- AddForeignKey
ALTER TABLE "DocumentTerm" ADD CONSTRAINT "DocumentTerm_pageId_fkey" FOREIGN KEY ("pageId") REFERENCES "Page"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentTerm" ADD CONSTRAINT "DocumentTerm_termId_fkey" FOREIGN KEY ("termId") REFERENCES "Term"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
