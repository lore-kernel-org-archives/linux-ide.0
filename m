From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x  LED enable request
Date: Mon, 8 Sep 2008 13:24:31 -0700 (PDT)
Message-ID: <804852.47037.qm@web903.biz.mail.mud.yahoo.com>
References: <48C5784D.5020206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web903.biz.mail.mud.yahoo.com ([216.252.100.43]:20902 "HELO
	web903.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753315AbYIHUYc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 16:24:32 -0400
In-Reply-To: <48C5784D.5020206@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

-- Tejun Heo <tj@kernel.org> wrote:

> Can you please format the message like the following with
> Signed-off-by and cc jeff@garzik.org?
> 
>   http://article.gmane.org/gmane.linux.ide/34108

Well, I can try.  But I couldn't figure out how to put the header lines
which list changes, insertions and deletions.  Sorry, but I'm not using
git and not familiar with git-diff or any of this formatting stuff.  I have 
an "a" and a "b" under directory /data/src/linxux-2.6.27-rc5.  I ran the 
following command to get the diff output that follows:

git-diff --src-prefix=  --dst-prefix=  -p a/drivers/ata/sata_inic162x.c
b/drivers/ata/sata_inic162x.c

If you can suggest what to run to also get the summary, I'll give it a shot.


Jeff,
This change enables the LED on the sata_inic162x.c driver.

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

