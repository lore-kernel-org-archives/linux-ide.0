From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 21:06:08 +0200
Message-ID: <200605152106.08239.arekm@maven.pl>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515101831.0e38d131.akpm@osdl.org> <4468C33F.7070905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:43023 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932317AbWEOTG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 15:06:26 -0400
In-Reply-To: <4468C33F.7070905@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Monday 15 May 2006 20:06, Jeff Garzik wrote:

> > http://bugzilla.kernel.org/show_bug.cgi?id=3D6260
>
> waiting on SATA ACPI merge.
Is this really a case?

The one (layering breaking; discussed already) patch cures the problem =
and=20
nothing sata acpi related is needed, so something else is problematic h=
ere I=20
guess.

--- 2.6.17-rc2/drivers/scsi/libata-core.c       2006-04-19 09:14:11.000=
000000=20
+0100=20
+++ linux/drivers/scsi/libata-core.c    2006-04-21 20:55:48.000000000 +=
0100=20
@@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a=20
 {=20
        if (ap->flags & ATA_FLAG_SUSPENDED) {=20
                ap->flags &=3D ~ATA_FLAG_SUSPENDED;=20
+               ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT=
);=20
                ata_set_mode(ap);=20
        }=20
        if (!ata_dev_present(dev))

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
