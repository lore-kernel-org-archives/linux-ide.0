From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x  LED enable request
Date: Mon, 8 Sep 2008 08:13:27 -0700 (PDT)
Message-ID: <885420.46850.qm@web902.biz.mail.mud.yahoo.com>
References: <48C516B4.80900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web902.biz.mail.mud.yahoo.com ([216.252.100.42]:39839 "HELO
	web902.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752204AbYIHPN2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 11:13:28 -0400
In-Reply-To: <48C516B4.80900@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: echo6 <echo6_uk@yahoo.com>, linux-ide@vger.kernel.org


--- Tejun Heo <tj@kernel.org> wrote:
> 
> Hmm... I have two - INIC-1622 V1.0 Septermber, 2003 and the one you
> have.  Till now, I haven't found any noticeable difference.
> Apparently, the meaning of the bit has changed.
> 
> > Which book are you using and are all these bits in the Global
> > Control register, which we call HOST_CTL?  Did I get an old book?
> 
> Yes, that's GCTRL.  Can you please do the '+' -> '|' change and resend
> the patch?

Sure; was just waiting to hear about the book versions in case they
had issued still another version.

--- linux-2.6.27-rc5.a/drivers/ata/sata_inic162x.c	2008-08-28
18:52:02.000000000 -0400
+++ linux-2.6.27-rc5.b/drivers/ata/sata_inic162x.c	2008-09-01
14:05:24.000000000 -0400
@@ -96,6 +96,7 @@
 	PORT_SCR		= 0x20,
 
 	/* HOST_CTL bits */
+	HCTL_LEDEN		= (1 << 3),  /* enable LED operation */
 	HCTL_IRQOFF		= (1 << 8),  /* global IRQ off */
 	HCTL_FTHD0		= (1 << 10), /* fifo threshold 0 */
 	HCTL_FTHD1		= (1 << 11), /* fifo threshold 1*/
@@ -540,7 +541,7 @@
 	void __iomem *port_base = inic_port_base(ap);
 
 	/* fire up the ADMA engine */
-	writew(HCTL_FTHD0, port_base + HOST_CTL);
+	writew(HCTL_FTHD0 | HCTL_LEDEN, port_base + HOST_CTL);
 	writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
 	writeb(0, port_base + PORT_CPB_PTQFIFO);
