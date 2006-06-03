From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv with Adaptec AIC-8130/Marvell 88SX6041 ("Badness in __msleep")
Date: Fri, 2 Jun 2006 22:45:49 -0400
Message-ID: <200606022245.49637.liml@rtr.ca>
References: <5D6C23F5-B03E-4C3D-8BC6-A009E51122D8@develooper.com> <447A614B.3050603@rtr.ca> <EA69B14D-2874-48EA-BF67-0A96DE690FA6@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:38024 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751078AbWFCCpw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 22:45:52 -0400
In-Reply-To: <EA69B14D-2874-48EA-BF67-0A96DE690FA6@develooper.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ask =?iso-8859-1?q?Bj=F8rn_Hansen?= <ask@develooper.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 02 June 2006 21:42, Ask Bj=F8rn Hansen wrote:
>=20
> On May 28, 2006, at 19:49, Mark Lord wrote:
>=20
> > The attached patch [0.7-backport] is an untested backport of the =20
> > latest sata_mv,
> > which should be more reliable than what you've been using. [0.5]
>=20
> It works most of the time (where the 0.5 didn't work most of the =20
> time), but I still see the "Badness in __msleep" occasionally (and it=
 =20
> only detects one of the disks then).    However, the Adaptec BIOS is =
=20
> only seeing one of the disks sometimes, so maybe there's something =20
> wrong with the hardware.  The BIOS did detect both drives in the boot=
 =20
> that gave the output below though.

Weird.  I cannot make sense of that traceback.  What CPU is this kernel=
 built for?

And does this patch (below) make the "Badness" go away?

Cheers

---
--- linux/drivers/scsi/sata_mv.c.16-backport	2006-05-26 09:15:22.000000=
000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-06-02 22:39:07.000000000 -0400
@@ -2022,7 +2022,7 @@
=20
 static void mv_phy_reset(struct ata_port *ap)
 {
-	__mv_phy_reset(ap, 1);
+	__mv_phy_reset(ap, 0);
 }
=20
 /**
