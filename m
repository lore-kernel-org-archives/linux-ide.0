From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 11:59:08 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085162347.4791.24.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu.
	pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:42422 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265938AbUEUR7T
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 13:59:19 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id 263201B44
	for <linux-ide@vger.kernel.org>; Fri, 21 May 2004 11:59:19 -0600 (MDT)
In-Reply-To: <200405211746.35015.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> Keep posting... seconded.

Hi!

Below inline is a trivial -bk8 patch that ducks ever trying PATAPI auto
sense.

In a kernel shipping with ATA_ENABLE_ATAPI defined, this would be a very
bad thing, because we thus falsely report success when in fact we have
not copied read data in or write data out.

But at my desk I find this alternative more usable than vanilla
2.6.6-bk8, because this way I don't have to issue unsolicited op x03
"REQUEST SENSE" to clear out the always-initially-present unit
attentions.  Instead, I just ignore the first few garbage results I get.

For example:

$ plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00" -v
x 00000000 25 00 00:00:00:00 00 00:00 00 .. .. .. .. .. .. "%@@@@@@@@@"
x 00000000 00:00:00:00 00:00:00:00 .. .. .. .. .. .. .. .. "@@@@@@@@"
// 0 = plscsi.main exit int
$
$ plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00" -v
x 00000000 25 00 00:00:00:00 00 00:00 00 .. .. .. .. .. .. "%@@@@@@@@@"
x 00000000 01:04:C9:3F 00:00:08:00 .. .. .. .. .. .. .. .. "ADI?@@H@"
// 0 = plscsi.main exit int
$

See that?  The first result is zeroed nonsense, courtesy the x 6 29
Reset unit attention we know was present.  Only the second result is
actually meaningful.

I can now proceed to test how well our DMA no-data/ data-in/ data-out
protocols work apart from timeout, auto sense, and the rest of error
recovery.

After that, I can return to inserting a PIO unsolicited op x03 "REQUEST
SENSE" after every command, and then beyond that I can make the auto
sense occur no more often than it should.

Pat LaVarre

diff -Nurp linux-2.6.6-bk8/drivers/scsi/libata-core.c linux-2.6.6-bk8-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk8/drivers/scsi/libata-core.c	2004-05-21 09:44:22.000000000 -0600
+++ linux-2.6.6-bk8-pel/drivers/scsi/libata-core.c	2004-05-21 11:29:01.571933824 -0600
@@ -2303,6 +2303,9 @@ void ata_qc_complete(struct ata_queued_c
 		ata_sg_clean(qc);
 
 	if (cmd) {
+#if 1 /* pretend good */ 
+		cmd->result = SAM_STAT_GOOD;
+#else /* FIXME: admit lost write data, stale read data, etc. */
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
 			if (is_atapi_taskfile(&qc->tf))
 				cmd->result = SAM_STAT_CHECK_CONDITION;
@@ -2311,6 +2314,7 @@ void ata_qc_complete(struct ata_queued_c
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}
+#endif
 
 		qc->scsidone(cmd);
 	}
diff -Nurp linux-2.6.6-bk8/drivers/scsi/libata-scsi.c linux-2.6.6-bk8-pel/drivers/scsi/libata-scsi.c


