From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: http://bugzilla.kernel.org/show_bug.cgi?id=11742
Date: Thu, 23 Oct 2008 08:09:32 +0200
Message-ID: <20081023060932.GA20217@gollum.tnic>
References: <20081020112039W.fujita.tomonori@lab.ntt.co.jp> <200810221645.22289.valerio.passini@unicam.it> <9ea470500810220857o153dd0fica23dc877fa895ce@mail.gmail.com> <200810230020.15257.valerio.passini@unicam.it>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:64980 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbYJWGJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 02:09:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so610476fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 22 Oct 2008 23:09:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810230020.15257.valerio.passini@unicam.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valerio Passini <valerio.passini@unicam.it>
Cc: linux-ide@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, bzolnier@gmail.com


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Valerio,

please do not remove people from the CC list because they're following the
discussion too, thanks.

> Hi Boris, first thank you for giving me that hint: kmail it's really my email client and it's guilty for the behaviour of cut and pasted text...

Next time just save the email in a text file and then try applying the patch in
it - I think this way works.

> I've just tried your patch above and it doesn't work and I have noticed a lot of messages during boot (see below).

Yep, it is _not_ supposed to work but instead tell us exactly why/which commands
puzzle your cdrom drive so that it turns off dma.

[.. ]

> [  182.374511] Disabling dma for ATA_PC, queue_dma_alignment: 0x1f, q->dma_pad_mask: 0xf,addr: 0xffff8800ab52a000, rq->data_len: 0x8, on_stack: 0

Can you now try this new patch I've attached below (before that revert the old
one by doing "patch -p1 -R < [file.patch]" recompile the kernel with it, reboot),
start simulated burning on your machine and then cancel it shortly thereafter.
Now do

dmesg > log.msg

and send me the _whole_ file so that we can see the messages you get while
burning.

Thanks.

-- 
Regards/Gruss,
    Boris.

--XsQoSWH+UP9D9v3l
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="inq2.patch"

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index f16bb46..118035c 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1165,7 +1165,6 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		struct request_queue *q = drive->queue;
 		unsigned int alignment;
 		unsigned long addr;
-		unsigned long stack_mask = ~(THREAD_SIZE - 1);
 
 		if (rq->bio)
 			addr = (unsigned long)bio_data(rq->bio);
@@ -1181,12 +1180,16 @@ static void cdrom_do_block_pc(ide_drive_t *drive, struct request *rq)
 		 * separate masks.
 		 */
 		alignment = queue_dma_alignment(q) | q->dma_pad_mask;
-		if (addr & alignment || rq->data_len & alignment)
-			info->dma = 0;
-
-		if (!((addr & stack_mask) ^
-		      ((unsigned long)current->stack & stack_mask)))
+		if (addr & alignment || rq->data_len & alignment
+			|| object_is_on_stack((void *)addr)) {
+			printk(KERN_ERR "Disabling dma for 0x%x cmd type, "
+					"queue_dma_alignment: 0x%x, q->dma_pad_mask: 0x%x,"
+					"addr: 0x%lx, rq->data_len: 0x%x, on_stack: %d\n",
+					rq->cmd_type,
+					queue_dma_alignment(q), q->dma_pad_mask, addr,
+					rq->data_len, object_is_on_stack((void *)addr));
 			info->dma = 0;
+		}
 	}
 }
 

--XsQoSWH+UP9D9v3l--
