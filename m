From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: BUG in ata_sff_hsm_move
Date: Fri, 29 Jan 2016 07:23:17 -0500
Message-ID: <20160129122317.GO32380@htj.duckdns.org>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
 <20160129115214.GM32380@htj.duckdns.org>
 <CACT4Y+Y_w3msrTw46T8wGpK-j09e6VAoPFa93JSfm+5_kvBAYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33393 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbcA2MXT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2016 07:23:19 -0500
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y_w3msrTw46T8wGpK-j09e6VAoPFa93JSfm+5_kvBAYQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>

Hello, Dmitry.

On Fri, Jan 29, 2016 at 12:59:49PM +0100, Dmitry Vyukov wrote:
> > Hmmm... the port interrupt handler checks for IDLE before calling into
> > hsm_move, so the only explanation would be that something is resetting
> > it to IDLE inbetween.  ce7514526742 ("libata: prevent HSM state change
> > race between ISR and PIO") describes and fixes the same problem.  The
> > fix seems correct and I can't find anywhere else where this can
> > happen.  :(
> >
> > Can you please post the kernel log leading to the BUG?  Also, I don't
> > think that condition needs to be BUG.  I'll change it to WARN.
> 
> Here are two logs, in both cases no kernel messages prior to the bug:
> https://gist.githubusercontent.com/dvyukov/5087d633e3620280b6c7/raw/31c9ab1ced92ac5f85cfb15eaf48ec5793c2c3a1/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/825b2e3d5fb80ae08a9a/raw/03c5a4f4c4bd9d0a304a71cda2da4c92f4b7f1ba/gistfile1.txt

lol, this is kinda embarrassing.  It looks like the poll path wasn't
doing any locking.  Can you please verify the following patch at least
doesn't crash the machine immediately and if so keep it applied to the
test kernel so that we can verify that the problem actually goes away?

Thanks.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 608677d..6991efc 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1362,12 +1362,14 @@ static void ata_sff_pio_task(struct work_struct *work)
 	u8 status;
 	int poll_next;
 
+	spin_lock_irq(ap->lock);
+
 	BUG_ON(ap->sff_pio_task_link == NULL);
 	/* qc can be NULL if timeout occurred */
 	qc = ata_qc_from_tag(ap, link->active_tag);
 	if (!qc) {
 		ap->sff_pio_task_link = NULL;
-		return;
+		goto out_unlock;
 	}
 
 fsm_start:
@@ -1382,11 +1384,14 @@ static void ata_sff_pio_task(struct work_struct *work)
 	 */
 	status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
 	if (status & ATA_BUSY) {
+		spin_unlock_irq(ap->lock);
 		ata_msleep(ap, 2);
+		spin_lock_irq(ap->lock);
+
 		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
 			ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
-			return;
+			goto out_unlock;
 		}
 	}
 
@@ -1403,6 +1408,8 @@ static void ata_sff_pio_task(struct work_struct *work)
 	 */
 	if (poll_next)
 		goto fsm_start;
+out_unlock:
+	spin_unlock_irq(ap->lock);
 }
 
 /**
