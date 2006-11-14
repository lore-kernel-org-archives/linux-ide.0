From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: fix passthru sense data header
Date: Tue, 14 Nov 2006 22:37:35 +0900
Message-ID: <1163511455437-git-send-email-htejun@gmail.com>
References: <11635114553453-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:1937 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965687AbWKNNhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:37:41 -0500
Received: by nz-out-0102.google.com with SMTP id l1so971449nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:37:40 -0800 (PST)
In-Reply-To: <11635114553453-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sb[7] should contain the length of whole information sense data
descriptor while desc[1] should contain the number of following bytes
in the descriptor.  ie. 14 for sb[7] but 12 for desc[1].

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a0b6ee1..8c9fa9e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -713,12 +713,9 @@ void ata_gen_ata_desc_sense(struct ata_q
 
 	desc[0] = 0x09;
 
-	/*
-	 * Set length of additional sense data.
-	 * Since we only populate descriptor 0, the total
-	 * length is the same (fixed) length as descriptor 0.
-	 */
-	desc[1] = sb[7] = 14;
+	/* set length of additional sense data */
+	sb[7] = 14;
+	desc[1] = 12;
 
 	/*
 	 * Copy registers into sense buffer.
-- 
1.4.3.3


