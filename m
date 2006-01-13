From: Diego Calleja <diegocg@gmail.com>
Subject: Re: [PATCH] documentation typo
Date: Fri, 13 Jan 2006 17:10:57 +0100
Message-ID: <20060113171057.3541db55.diegocg@gmail.com>
References: <20060105132014.d72f61db.diegocg@gmail.com>
	<58cb370e0601050643q3147cfc8g46e3d17990b196a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.205]:53483 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965008AbWAMQSE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jan 2006 11:18:04 -0500
Received: by uproxy.gmail.com with SMTP id s2so43283uge
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 08:18:03 -0800 (PST)
In-Reply-To: <58cb370e0601050643q3147cfc8g46e3d17990b196a8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

El Thu, 5 Jan 2006 15:43:53 +0100,
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> escribi=F3:

> I would greatly appreciate if you update ide.txt accordingly.


If this doesn't look OK (it's crappy to paste command examples
instead of explaining the interface) I'll rewrite it after the
weekend.

--- test/Documentation/ide.txt.old	2006-01-13 16:58:28.000000000 +0100
+++ test/Documentation/ide.txt	2006-01-13 17:08:08.000000000 +0100
@@ -244,10 +244,44 @@ Summary of ide driver parameters for ker
=20
  "hdx=3Dbswap"		: same as above..........
=20
- "hdx=3Dscsi"		: the return of the ide-scsi flag, this is useful for
+ "hdx=3Dide-scsi" (*)	: the return of the ide-scsi flag, this is usefu=
l for
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
=20
+ "hdx=3Dscsi" (*)	: This option tells IDE drivers not to bind to devic=
e
+			  "hdx"
+
+ [(*) Notice that in current kernels you can use the generic sysfs int=
erface
+  to bind/unbind devices to drivers dynamically without using "hdx=3Ds=
csi"
+  and/or "hdx=3Dide-scsi", so those boot options may be deprecated in =
the future,
+  ej:
+
+   [root@trik /]# cd /sys/bus/ide/drivers/
+   [root@trik drivers]# ls
+   ide-cdrom  ide-disk  ide-scsi
+   [root@trik drivers]# ls ide-cdrom ide-scsi
+   ide-cdrom:
+   1.0  bind  module  unbind
+  =20
+   ide-scsi:
+   bind  module  unbind
+   [root@trik drivers]# echo -n "1.0">ide-cdrom/unbind
+   [root@trik drivers]# ls ide-cdrom ide-scsi
+   ide-cdrom:
+   bind  module  unbind
+  =20
+   ide-scsi:
+   bind  module  unbind
+   [root@trik drivers]# echo -n "1.0">ide-scsi/bind
+   [root@trik drivers]# ls ide-cdrom ide-scsi
+   ide-cdrom:
+   bind  module  unbind
+  =20
+   ide-scsi:
+   1.0  bind  module  unbind
+   [root@trik drivers]#
+  =20
+
  "idebus=3Dxx"		: inform IDE driver of VESA/PCI bus speed in MHz,
 			  where "xx" is between 20 and 66 inclusive,
 			  used when tuning chipset PIO modes.
