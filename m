From: Tejun Heo <htejun@gmail.com>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Sat, 03 Nov 2007 10:17:12 +0900
Message-ID: <472BCC18.7070503@gmail.com>
References: <47274A5F.6070409@gentoo.org>	<20071030153417.59b9182c@the-village.bc.nu>	<47276DCA.1000808@gentoo.org>	<20071030190153.373c9347@the-village.bc.nu>	<47278439.4030801@gentoo.org>	<20071031114958.210bd7cc@the-village.bc.nu>	<20071031115754.GK5059@kernel.dk>	<4729A0DF.20800@garzik.org>	<20071101105335.1f20bab3@the-village.bc.nu>	<4729B3EA.6040707@garzik.org> <20071101141501.3746cec2@the-village.bc.nu> <4729F1BB.20306@gentoo.org> <4729F8F1.4040103@gmail.com> <472B946F.4030004@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030406010007080403040101"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:21005 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbXKCBRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 21:17:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1129715wah
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 18:17:23 -0700 (PDT)
In-Reply-To: <472B946F.4030004@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Jens Axboe <jens.axboe@oracle.com>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

This is a multi-part message in MIME format.
--------------030406010007080403040101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Daniel Drake wrote:
> Tejun Heo wrote:
>> Yeap, the SG command is fine.  The drive is being weird tho.  The
>> allocation length field says 10 bytes, so it should just have
>> transferred 10 bytes without causing HSM violation.
>>
>> Can you please apply the attached patch and report what the kernel says
>> after triggering the error condition?
> 
> Thanks for looking at this, the kernel now says:
> 
> <4>ata2.00: HSM violation: eh_analyze_tf: BUSY|DRQ
> <3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> <3>ata2.00: cmd a0/00:00:00:0a:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data
> 10 in
> <4>         res 58/00:02:00:0a:00/00:00:00:00:00/a0 Emask 0x2 (HSM
> violation)
> <3>ata2.00: status: { DRDY DRQ }
> <6>ata2: soft resetting link
> <6>ata2.00: configured for UDMA/33
> <6>ata2: EH complete

Does this patch fix the problem?

-- 
tejun

--------------030406010007080403040101
Content-Type: text/x-patch;
 name="drain.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drain.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ee56e5..5488637 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4994,19 +4994,15 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	struct scatterlist *sg = qc->__sg;
-	struct scatterlist *lsg = sg_last(qc->__sg, qc->n_elem);
 	struct ata_port *ap = qc->ap;
+	struct scatterlist *sg;
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
-	int no_more_sg = 0;
 
-	if (qc->curbytes + bytes >= qc->nbytes)
-		ap->hsm_task_state = HSM_ST_LAST;
-
-next_sg:
-	if (unlikely(no_more_sg)) {
+ next_sg:
+	sg = qc->cursg;
+	if (unlikely(!sg)) {
 		/*
 		 * The end of qc->sg is reached and the device expects
 		 * more data to transfer. In order not to overrun qc->sg
@@ -5024,13 +5020,9 @@ next_sg:
 
 		for (i = 0; i < words; i++)
 			ap->ops->data_xfer(qc->dev, (unsigned char *)pad_buf, 2, do_write);
-
-		ap->hsm_task_state = HSM_ST_LAST;
 		return;
 	}
 
-	sg = qc->cursg;
-
 	page = sg_page(sg);
 	offset = sg->offset + qc->cursg_ofs;
 
@@ -5068,9 +5060,6 @@ next_sg:
 	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == sg->length) {
-		if (qc->cursg == lsg)
-			no_more_sg = 1;
-
 		qc->cursg = sg_next(qc->cursg);
 		qc->cursg_ofs = 0;
 	}

--------------030406010007080403040101--
