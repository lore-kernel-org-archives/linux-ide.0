Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D472D7DFE
	for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563647; cv=none; b=IfmakatMaevWgusdXWxPc9D8ebmVpDHp+W/wX5xzSOwFQnI+NB8JIjGn51Ejtso/dcMuf9+tRbnplX3jwc+LRicLfXXbI4gRGXhqQh/4W1KP9Tb05OLs0GzVYl4CBvzWiQeUS5RMcpY1I6qqqxnlZwj/pwMteuA3Qz9guQhgMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563647; c=relaxed/simple;
	bh=5OO6IBhm9pVRLQqZGVnqU/PwymDmZORPNdcCbouTco0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSlLa8ePynyCJaGpYA2/I8isUpCJdmDcjCp8cncVvt6QC62ZNPnfEeO7o8SqtCicp2lau5vXmXkyBmBI/MwZDFPZ5XLhW1R7uG1Q1dvO1wCPZ8fXfKj2LW2bX78Q2ToZJKeahTMZuxxcOBCKSjf2jAg4uvjGrqM8O+E3OItPMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmhWr2d6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmhWr2d6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010A1F000FF;
	Wed, 16 Sep 2026 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563645;
	bh=dsJz6wH0TLLRWXxc7FR5LdERxqumVyqrmuLRanWtroM=;
	h=From:To:Cc:Subject:Date;
	b=SmhWr2d6uYWHJaNLTt6+6MXk4Jz8fMCWTzMKjEPnh+5IZ7CIbusQCeCyq8PmnxAUv
	 qyTHC7kXi2nHJcAMm9jcbEgMlHm6p4JEbPTxjOslEFwupqhAKhEuuQD9fnHUavBE8P
	 WLk56KrnUPIDDO0poDcor6OsIeQEamzbDISKJDMySwEof8pWTBFqZzq5EJHP+VuaSC
	 9jIWlPIa7d6gJYCMdz4qaNwNkBjKle2XBJLDoOIvSJo8v997bpAGfspr2O0NddgARR
	 f25pTAdwcz9T9kuv/yANk6xlW0/1GF+wsIHW0159uaDE2KpWSbO/djLZd6/yvMPFmw
	 PM8WeygBkkHbQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc
Date: Wed, 16 Sep 2026 15:00:32 +0200
Message-ID: <20260916130031.29990-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=cassel@kernel.org; h=from:subject; bh=5OO6IBhm9pVRLQqZGVnqU/PwymDmZORPNdcCbouTco0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWTXo/l9Vu0tQ970JfL+V/8iBs1sVov80nC4OVv3p83 dfVVPc0uKOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATSb/KyPCOO+8Nn0m+19OA 104/wwUPfE0K+3rZRERxYcKMM4vdQ3wZ/vDb3/ZLCVvfq5e/1OKl3+bCJ7tfpyUWqoTWsFpOiEh rZgYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

make htmldocs fails with:

  Documentation/driver-api/libata:604: ./drivers/ata/libata-scsi.c:2301:
  ERROR: Unexpected indentation. [docutils]

The Return: section of ata_dsm_trim_pages() ends its first sentence with
a colon and continues with an indented bullet list. reStructuredText
requires a blank line before an indented block, so docutils chokes on
the list.

Simply adding the missing blank line does not work either: Return: is a
kernel-doc "special section", which is terminated by the first blank
line, so the bullet list would end up in the Description section,
detached from the sentence introducing it.

Spell the two bounds out as prose instead, so that the Return: section
stays self-contained. Documentation-only change.

Fixes: e64e6b5dc867 ("ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND")
Reported-by: Thomas Huth <thuth@redhat.com>
Closes: https://lore.kernel.org/linux-ide/b0a0b8e8-cc4f-4c7b-8bc5-fee0712d405a@redhat.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b3666519b648..7e22bbc38238 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2297,10 +2297,9 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
  * logical block, so it can hold at most sector_size / 512 pages.
  *
  * Return: the maximum number of 512-byte pages a single translated WRITE SAME
- * command may send to @dev (never less than one), that is the smaller of:
- *   - MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word 105), when the device
- *     reports a non-zero limit; and
- *   - the logical sector size expressed in 512-byte pages (see above).
+ * command may send to @dev, that is the smaller of MAX PAGES PER DSM COMMAND
+ * (IDENTIFY DEVICE word 105, when the device reports a non-zero limit) and
+ * the logical sector size expressed in 512-byte pages; never less than one.
  */
 static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
 {
-- 
2.55.0

