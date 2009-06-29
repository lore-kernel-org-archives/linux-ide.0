From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Mon, 29 Jun 2009 23:09:20 +0900
Message-ID: <4A48CB10.5020409@kernel.org>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de> <49F3C03C.1090803@kernel.org> <4A36FC7D.5050805@hadiko.de> <4A388E1F.5070404@kernel.org> <4A3FD015.4090602@hadiko.de> <4A443366.4010807@kernel.org> <4A4878B3.9020206@hadiko.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010807070500020407010503"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53721 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZF2OJ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jun 2009 10:09:26 -0400
In-Reply-To: <4A4878B3.9020206@hadiko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <aXe@hadiko.de>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807070500020407010503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thomas Jackowski wrote:
> there is no relevant output in this loop (running about 6 hours).

Hmm... can you please try the attached patch?  It should show us who's
issuing the CPM.

Thanks.

-- 
tejun

--------------010807070500020407010503
Content-Type: text/x-patch;
 name="whos-doing-cpm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="whos-doing-cpm.patch"

diff --git a/block/elevator.c b/block/elevator.c
index 7073a90..93e6575 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -618,6 +618,16 @@ void elv_insert(struct request_queue *q, struct request *rq, int where)
 	unsigned ordseq;
 	int unplug_it = 1;
 
+	if (rq->cmd[0] == 0xa1 || rq->cmd[0] == 0x85) {
+		u8 cmd = rq->cmd[0] == 0xa1 ? rq->cmd[9] : rq->cmd[14];
+
+		if (cmd == 0xe5) {
+			printk("XXX %s: elv_insert(ATA_CHK_POWER)\n",
+			       rq->rq_disk ? rq->rq_disk->disk_name : "?");
+			dump_stack();
+		}
+	}
+
 	trace_block_rq_insert(q, rq);
 
 	rq->q = q;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 94919ad..a56c53d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2722,6 +2722,7 @@ static void ata_eh_park_issue_cmd(struct ata_device *dev, int park)
 		tf.lbah = 0x55;
 	} else {
 		ehc->unloaded_mask &= ~(1 << dev->devno);
+		ata_dev_printk(dev, KERN_INFO, "XXX issuing CHK_POWER for unparking\n");
 		tf.command = ATA_CMD_CHK_POWER;
 	}
 

--------------010807070500020407010503--
