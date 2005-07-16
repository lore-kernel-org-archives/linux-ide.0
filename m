From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: hotplug event on fdisk?
Date: Sat, 16 Jul 2005 21:24:52 +0400
Message-ID: <20050716212452.531e0a84.vsu@altlinux.ru>
References: <42D3E880.6060902@imc-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__16_Jul_2005_21_24_52_+0400_Yrj7lRo.a8bSQG3h"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.murom.net ([213.177.124.17]:16818 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261500AbVGPRZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jul 2005 13:25:17 -0400
In-Reply-To: <42D3E880.6060902@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

--Signature=_Sat__16_Jul_2005_21_24_52_+0400_Yrj7lRo.a8bSQG3h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 12 Jul 2005 17:57:52 +0200 Steven Scholz wrote:

> I noticed that /sbin/hotplug is called by the kernel when I am doing
> 
> 	fdisk -l /dev/hda
> 
> to do a "remove" and then do "add" again:
> 
> ~ # fdisk -l /dev/hda
> kobject_hotplug
> kobject_hotplug: /sbin/hotplug block seq=574 HOME=/ 
> PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/block/hda/hda1 
> SUBSYSTEM=block
>   hda: hda1
> kobject_hotplug
> kobject_hotplug: /sbin/hotplug block seq=575 HOME=/ 
> PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/block/hda/hda1
> SUBSYSTEM=block
> 
> Disk /dev/hda: 512 MB, 512483328 bytes
> 16 heads, 63 sectors/track, 993 cylinders
> Units = cylinders of 1008 * 512 = 516096 bytes
> 
>     Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *           1         993      500440+   6  FAT16
> 
> 
> Why is it so? And what is the system suposed to do? Actually remove
> the device?

Looking at the size of your device (512 MB), I guess that it is some
king of flash drive.  Such devices pretend to be removable hard disks -
and here the "removable" bit causes trouble.

ide-disk.c:idedisk_open() has this code:

	if (drive->removable && drive->usage == 1) {
		... unrelated code for door locking ...
		check_disk_change(inode->i_bdev);
		...

This code detects the opening of a previously unused removable device
and checks if the disk was changed.  check_disk_change() applied to an
IDE disk device used idedisk_media_changed() to find out if the disk
really was changed; this function is rather simple:

static int idedisk_media_changed(struct gendisk *disk)
{
	struct ide_disk_obj *idkp = ide_disk_g(disk);
	ide_drive_t *drive = idkp->drive;

	/* do not scan partitions twice if this is a removable device */
	if (drive->attach) {
		drive->attach = 0;
		return 0;
	}
	/* if removable, always assume it was changed */
	return drive->removable;
}

Seems that either IDE does not have a command to check for disk change,
or such command is unreliable on many devices, or maybe the needed code
is simply not implemented.  Anyway, the end result is that every open of
an otherwise unused removable IDE disk results in invalidation of the
partition table - therefore you see all that hotplug events.

BTW, such behavior of the kernel also causes problems with, e.g., HAL
(when HAL tries to look at the CompactFlash drive to find out what
partitions does it contain, this results in hotplug events for all
partitions; with some HAL versions and configurations this can result in
an endless loop).

One possible workaround is to consider flash drives as non-removable in
idedisk_media_changed().  For typical CompactFlash drives used with
ide-cs, this is actually correct - the actual media is not removable
from such drive, the IDE _controller_ is added and removed instead.
However, I'm not sure if this would be correct for all possible
configurations.

Anyway, here is the patch with such workaround for CompactFlash (against
the current git tree, but it should also apply to earlier kernels with
some fuzz).

---
Subject: [PATCH] Avoid superfluous rechecking of partitions for IDE flash drives

For some reason, IDE flash drives report that they have removable media,
which is not really correct - the drive as a whole is removed, therefore
rescanning of the partition table on the first open of such devices is
just a waste of time.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1174,6 +1174,14 @@ static int idedisk_media_changed(struct 
 	struct ide_disk_obj *idkp = ide_disk_g(disk);
 	ide_drive_t *drive = idkp->drive;
 
+	/*
+	 * PCMCIA flash drives report themselves as removable, but can be
+	 * treated as fixed - when such device is removed, its IDE controller
+	 * also disappears.
+	 */
+	if (drive->is_flash)
+		return 0;
+
 	/* do not scan partitions twice if this is a removable device */
 	if (drive->attach) {
 		drive->attach = 0;

--Signature=_Sat__16_Jul_2005_21_24_52_+0400_Yrj7lRo.a8bSQG3h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC2ULoW82GfkQfsqIRAijBAJ40qmSBJkmrAOEKOVie9CrAULUI2wCghuQq
gXXSMRejLPt1r2Oav6ejPI4=
=69jn
-----END PGP SIGNATURE-----

--Signature=_Sat__16_Jul_2005_21_24_52_+0400_Yrj7lRo.a8bSQG3h--
