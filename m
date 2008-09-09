From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x  LED enable request
Date: Tue, 9 Sep 2008 12:41:48 -0700 (PDT)
Message-ID: <962320.92633.qm@web902.biz.mail.mud.yahoo.com>
References: <48C62B68.10502@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web902.biz.mail.mud.yahoo.com ([216.252.100.42]:30660 "HELO
	web902.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753165AbYIITlt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 15:41:49 -0400
In-Reply-To: <48C62B68.10502@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org


--- Tejun Heo <tj@kernel.org> wrote:

> Bob Stewart wrote:
> > Well, I can try.  But I couldn't figure out how to put the header lines
> > which list changes, insertions and deletions.  Sorry, but I'm not using
> > git and not familiar with git-diff or any of this formatting stuff.  I have
> 
> > an "a" and a "b" under directory /data/src/linxux-2.6.27-rc5.  I ran the 
> > following command to get the diff output that follows:
> 
> Oh.. You can generate the summary using diffstat.  Just do diffstat
> -p1 < patch and paste the output in.
> 
> Thanks.

OK, third try.  Patch to enable LED on sata_inic162x.c


 drivers/ata/sata_inic162x.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 3ead02f..5032c32 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -96,6 +96,7 @@ enum {
 	PORT_SCR		= 0x20,
 
 	/* HOST_CTL bits */
+	HCTL_LEDEN		= (1 << 3),  /* enable LED operation */
 	HCTL_IRQOFF		= (1 << 8),  /* global IRQ off */
 	HCTL_FTHD0		= (1 << 10), /* fifo threshold 0 */
 	HCTL_FTHD1		= (1 << 11), /* fifo threshold 1*/
@@ -540,7 +541,7 @@ static unsigned int inic_qc_issue(struct ata_queued_cmd
*qc)
 	void __iomem *port_base = inic_port_base(ap);
 
 	/* fire up the ADMA engine */
-	writew(HCTL_FTHD0, port_base + HOST_CTL);
+	writew(HCTL_FTHD0 | HCTL_LEDEN, port_base + HOST_CTL);
 	writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
 	writeb(0, port_base + PORT_CPB_PTQFIFO);
 
