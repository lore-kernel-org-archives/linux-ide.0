From: Justin Maggard <jmaggard10@gmail.com>
Subject: Re: Hotplug issue with Marvell 6121
Date: Wed, 10 Mar 2010 14:46:45 -0800
Message-ID: <150c16851003101446m633ad174tc784a94e2a2a5a5b@mail.gmail.com>
References: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f204.google.com ([209.85.221.204]:40119 "EHLO
	mail-qy0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab0CJWqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2010 17:46:47 -0500
Received: by qyk42 with SMTP id 42so2066531qyk.19
        for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2010 14:46:45 -0800 (PST)
In-Reply-To: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, Mar 9, 2010 at 4:51 PM, Justin Maggard <jmaggard10@gmail.com> w=
rote:
> I've been experiencing some issues with disk hotplugging using the
> AHCI driver with a Marvell 6121 controller. =A0It varies a bit when t=
he
> driver gives up, but it's almost always within the first three
> remove/add attempts. =A0I was using 2.6.27.6 for quite some time and
> never had any issues with hotplug, even after many hotplugs. =A0The
> problems started when I updated to 2.6.29, and they still exist today
> on 2.6.33. =A0I'm running a regular i686 non-SMP kernel. =A0Anyone ha=
ve
> any ideas?
>
Okay, so I did some more investigation and narrowed down the issue.
It seems the Marvell controller (at least the 6121) doesn't like when
you limit the link speed.  So when the libata error handler slows down
the link speed on the last hard reset after the disk is removed, there
is a good chance that a newly-added disk on that channel will not be
recognized when you plug it in.

I'm sure there's a much better way to fix it, as this patch feels
terribly wrong... but it fixes the issue for me.  Any chance of this
getting addressed upstream?

--- linux-2.6.33.orig/drivers/ata/libata-eh.c	2010-02-24
10:52:17.000000000 -0800
+++ linux-2.6.33/drivers/ata/libata-eh.c	2010-03-10 13:13:37.000000000 =
-0800
@@ -3300,9 +3305,11 @@ static int ata_eh_schedule_probe(struct
 	return 1;
 }

+#define AHCI_HFLAG_MV_PATA (1 << 4)
 static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
 {
 	struct ata_eh_context *ehc =3D &dev->link->eh_context;
+	unsigned int *hflags =3D dev->link->ap->host->private_data;

 	/* -EAGAIN from EH routine indicates retry without prejudice.
 	 * The requester is responsible for ensuring forward progress.
@@ -3322,7 +3329,12 @@ static int ata_eh_handle_dev_fail(struct
 			/* This is the last chance, better to slow
 			 * down than lose it.
 			 */
-			sata_down_spd_limit(ata_dev_phys_link(dev), 0);
+			if (*hflags & AHCI_HFLAG_MV_PATA) {
+				ata_dev_printk(dev, KERN_WARNING,
+					"Marvell controller detected,"
+					" not slowing down link\n");
+			} else
+				sata_down_spd_limit(ata_dev_phys_link(dev), 0);
 			if (dev->pio_mode > XFER_PIO_0)
 				ata_down_xfermask_limit(dev, ATA_DNXFER_PIO);
 		}
