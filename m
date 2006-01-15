From: Diego Calleja <diegocg@gmail.com>
Subject: Re: [PATCH] documentation typo
Date: Sun, 15 Jan 2006 23:24:03 +0100
Message-ID: <20060115232403.a8f970d1.diegocg@gmail.com>
References: <20060105132014.d72f61db.diegocg@gmail.com>
	<58cb370e0601050643q3147cfc8g46e3d17990b196a8@mail.gmail.com>
	<20060113171057.3541db55.diegocg@gmail.com>
	<58cb370e0601130817i5f65c93fx469a49259b86d592@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.197]:42219 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750960AbWAOWYz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jan 2006 17:24:55 -0500
Received: by uproxy.gmail.com with SMTP id s2so466919uge
        for <linux-ide@vger.kernel.org>; Sun, 15 Jan 2006 14:24:53 -0800 (PST)
In-Reply-To: <58cb370e0601130817i5f65c93fx469a49259b86d592@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

El Fri, 13 Jan 2006 17:17:33 +0100,
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> escribi=F3:

> Well, examples are fine but some explanation would be needed.
> I'll wait for revised version (please also add that you need
> CONFIG_HOTPLUG=3Dy for using sysfs interface - this is due
> one of the recent changes in the kernel driver core).

Of, this is not 100% perfect but it's much better:

- I added a CONFIG_HOTPLUG dependeny for ide-scsi. If the sysfs interfa=
ce
  is the Right Way of doing it and the boot parameters are going to be
  removed some day, it has sense no?

- I "deprecated" the boot parameters by adding a printk and a entry to
  feature-removal-schedule.txt. I don't know if this is what you want
  but I though it was the right thing

Index: test/Documentation/ide.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- test.orig/Documentation/ide.txt	2006-01-13 16:58:28.000000000 +0100
+++ test/Documentation/ide.txt	2006-01-15 23:08:34.000000000 +0100
@@ -244,9 +244,15 @@
=20
  "hdx=3Dbswap"		: same as above..........
=20
- "hdx=3Dscsi"		: the return of the ide-scsi flag, this is useful for
+ "hdx=3Dide-scsi"		: the return of the ide-scsi flag, this is useful f=
or
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
+			  NOTE: This boot option is deprecated (*) and may be
+			  removed in the future
+
+ "hdx=3Dscsi"		: This option tells IDE drivers not to bind to device
+			  "hdx". NOTE: This boot option is deprecated (*) and
+			  may be removed in the future.
=20
  "idebus=3Dxx"		: inform IDE driver of VESA/PCI bus speed in MHz,
 			  where "xx" is between 20 and 66 inclusive,
@@ -317,8 +323,44 @@
=20
 Everything else is rejected with a "BAD OPTION" message.
=20
+
+(*): hdx=3Dide-scsi and hdx=3Dscsi boot options: These two boot option=
s have been
+deprecated by a new sysfs interface, which allows to bind/unbind devic=
es to
+drivers dinamically. Notice that you need to enable CONFIG_HOTPLUG (Ho=
tplug
+support) to use this:
+
+For every IDE bus in the system, there's a /sys/devices/$PCIBUS/$PCIID=
/idex/
+subdirectory (where $PCIBUS is the identifier of the PCI bus, somethin=
g like
+"pci0000:00", and $PCIID is the PCI ID of the ide bus device - the sam=
e you get
+when you run lspci - something like "0000:00:0f.1". idex is ide0, ide1=
, etc)
+
+In each one of those subdirectories, there's another subdirectory with=
 a name
+like "0.0", "1.0", etc: The first number identifies the IDE bus (ide0,=
 ide1
+etc) and the second one the device connected at that bus. That subdire=
ctory
+has some information about your device and more subdirectories pointin=
g to
+other places in the sysfs tree where you can find information related =
with
+that device. You can also get those names by running "systool -b ide".
+
+The ide-disk, ide-cdrom and ide-scsi drivers also have their own sysfs
+subdirectory at /sys/bus/ide/drivers/ide-disk/, /sys/bus/ide/drivers/i=
de-scsi/,
+etc. In each one of those subdirectories there's a bind and a unbind f=
ile. The
+way to bind/unbind a device to a driver dinamically is to write the "n=
ame"
+of those files; ej: echo "1.0" > /sys/bus/ide/drivers/ide-scsi/bind to=
 bind
+the device 1.0 to the ide-scsi driver. A symlink named "1.0" will appe=
ar in the
+ide-scsi/ directory pointing to the /sys/devices/$PCIBUS/$PCIID/ide1/1=
=2E0/
+directory. In that directory, you'll also "driver" symlink pointing ba=
ck
+to the ide-scsi subdirectory. Alternatively, you can see the current s=
tate
+of all the ide interfaces by running "systools -b ide -D"
+
+While this is more complex than adding a boot parameter, this allows t=
o
+change the device/driver bindings dynamically so no static boot parame=
ters
+are needed (which is useful for distros so they can run in different
+hardware configurations where devices are detected dinamically and
+binded/unbinded to different interfaces dinamically)
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
+
 IDE ATAPI streaming tape driver
 -------------------------------
=20
Index: test/drivers/ide/ide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- test.orig/drivers/ide/ide.c	2006-01-13 02:40:44.000000000 +0100
+++ test/drivers/ide/ide.c	2006-01-15 22:00:14.000000000 +0100
@@ -1554,6 +1554,9 @@
 		hwif =3D &ide_hwifs[hw];
 		drive =3D &hwif->drives[unit];
 		if (strncmp(s + 4, "ide-", 4) =3D=3D 0) {
+			printk("hd%c: \"hdx=3Dide-scsi\" boot parameter has been
+			    obsoleted by a better mechanism and may be removed
+			    in the future, check Documentation/ide.txt\n", unit);
 			strlcpy(drive->driver_req, s + 4, sizeof(drive->driver_req));
 			goto done;
 		}
@@ -1593,6 +1596,10 @@
 				drive->sect0 =3D 63;
 				goto done;
 			case -14: /* "scsi" */
+				printk("hd%c: \"hdx=3Dscsi\" boot parameter has
+				    been obsoleted by a better mechanism and may
+				    be removed in the future, check
+				    Documentation/ide.txt\n", unit);
 				drive->scsi =3D 1;
 				goto done;
 			case 3: /* cyl,head,sect */
Index: test/Documentation/feature-removal-schedule.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- test.orig/Documentation/feature-removal-schedule.txt	2006-01-13 02:=
40:41.000000000 +0100
+++ test/Documentation/feature-removal-schedule.txt	2006-01-15 22:07:28=
=2E000000000 +0100
@@ -139,3 +139,12 @@
 	brother on Alchemy SOCs.  The loss of features is not considered an
 	issue.
 Who:	Ralf Baechle <ralf@linux-mips.org>
+
+---------------------------
+
+What:	hdx=3Dide-scsi/hdx=3Dscsi boot parameters
+When:	June 2006
+Why:	In current kernels there's a sysfs interface to bind/unbind devic=
es
+	to drivers dynamically which replaces those parameters, see
+	Documentation/ide.txt
+Who:	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Index: test/drivers/ide/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- test.orig/drivers/ide/Kconfig	2006-01-13 02:40:44.000000000 +0100
+++ test/drivers/ide/Kconfig	2006-01-15 23:13:41.000000000 +0100
@@ -234,7 +234,7 @@
=20
 config BLK_DEV_IDESCSI
 	tristate "SCSI emulation support"
-	depends on SCSI
+	depends on SCSI && HOTPLUG
 	---help---
 	  WARNING: ide-scsi is no longer needed for cd writing applications!
 	  The 2.6 kernel supports direct writing to ide-cd, which eliminates
@@ -249,12 +249,10 @@
 	  driver has been written (for example, an ATAPI PD-CD drive);
 	  you can then use this emulation together with an appropriate SCSI
 	  device driver. In order to do this, say Y here and to "SCSI support=
"
-	  and "SCSI generic support", below. You must then provide the kernel
-	  command line "hdx=3Dide-scsi" (try "man bootparam" or see the
-	  documentation of your boot loader (lilo or loadlin) about how to
-	  pass options to the kernel at boot time) for devices if you want th=
e
-	  native EIDE sub-drivers to skip over the native support, so that
-	  this SCSI emulation can be used instead.
+	  and "SCSI generic support", below. To force a device to use this
+	  SCSI emulation interface you can use sysfs to do it at runtime as
+	  explained in <file:Documentation/ide.txt> (notice that this needs
+	  CONFIG_HOTPLUG)
=20
 	  Note that this option does NOT allow you to attach SCSI devices to =
a
 	  box that doesn't have a SCSI host adapter installed.

