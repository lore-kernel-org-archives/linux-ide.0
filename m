From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14708] Option remap63 for OnTrack diskmanager not work - kernel
 panic, unable to mount root filesystem
Date: Sun, 14 Nov 2010 23:14:41 GMT
Message-ID: <201011142314.oAENEfIQ008947@demeter1.kernel.org>
References: <bug-14708-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:42387 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab0KNXOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Nov 2010 18:14:42 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id oAENEfUi008948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 14 Nov 2010 23:14:41 GMT
In-Reply-To: <bug-14708-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14708





--- Comment #2 from sachse@gmx.net  2010-11-14 23:14:40 ---
remap63 is still missing and device mapper is not working!
Please provide a solution here!

$ fdisk -l /dev/hda
Disk /dev/hda: 100.0 GB, 100030242816 bytes
255 heads, 63 sectors/track, 12161 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1        1027     8249373   54  OnTrackDM6

$ echo 0 $(( `blockdev --getsize /dev/hda` - 63 )) linear /dev/hda 63
|dmsetup create dmhda

$ fdisk -l /dev/mapper/dmhda
Disk /dev/mapper/dmhda: 100.0 GB, 100030210560 bytes
255 heads, 63 sectors/track, 12161 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

            Device Boot      Start         End      Blocks   Id  System
/dev/mapper/dmhda1   *           1         261     2096451    6  FAT16
/dev/mapper/dmhda2             262         759     4000153+   7  HPFS/NTFS
/dev/mapper/dmhda3             760         761       16033+  83  Linux
/dev/mapper/dmhda4             762       12161    91570500    5  Extended
/dev/mapper/dmhda5             762         824      506016   82  Linux swap
/dev/mapper/dmhda6             825        9579    70324506   83  Linux
/dev/mapper/dmhda7            9580       12161    20739883+   7  HPFS/NTFS

Disk /dev/mapper/dmhda: 255 heads, 63 sectors, 12161 cylinders

Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID
 1 80   1   1    0 254  63  260         63    4192902 06
 2 00   1   1  261 254  63  758    4193028    8000307 07
 3 00   1   1  759 254  63  760   12193398      32067 83
 4 00   0   1  761 254  63 1023   12225465  183141000 05
 5 00   1   1  761 254  63  823         63    1012032 82
 6 00   1   1  824 254  63 1023         63  140649012 83
 7 00 254  63 1023 254  63 1023         63   41479767 07

$ kpartx -l /dev/mapper/dmhda
dmhda1 : 0 4192902 /dev/mapper/dmhda 63
dmhda2 : 0 8000307 /dev/mapper/dmhda 4193028
dmhda3 : 0 32067 /dev/mapper/dmhda 12193398
dmhda4 : 0 183141000 /dev/mapper/dmhda 12225465
dmhda5 : 0 1012032 /dev/dm-3 63              <- FAIL
dmhda6 : 0 140649012 /dev/dm-3 1012158       <- FAIL
dmhda7 : 0 41479767 /dev/dm-3 141661233      <- FAIL

FAIL because kpartx is unable to handle logical paritions.

livecd ~ # partx -av /dev/mapper/dmhda
device /dev/mapper/dmhda: start 0 size 195371505
gpt: 0 slices
dos: 7 slices
# 1:        63-  4192964 (  4192902 sectors,   2146 MB)
# 2:   4193028- 12193334 (  8000307 sectors,   4096 MB)
# 3:  12193398- 12225464 (    32067 sectors,     16 MB)
# 4:  12225465-195366464 (183141000 sectors,  93768 MB)
# 5:  12225528- 13237559 (  1012032 sectors,    518 MB)
# 6:  13237623-153886634 (140649012 sectors,  72012 MB)
# 7: 153886698-195366464 ( 41479767 sectors,  21237 MB)
reduced size of partition #4 to 63
BLKPG: Invalid argument
error adding partition 1
BLKPG: Invalid argument
error adding partition 2
BLKPG: Invalid argument
error adding partition 3
BLKPG: Invalid argument
error adding partition 4
BLKPG: Invalid argument
error adding partition 5
BLKPG: Invalid argument
error adding partition 6
BLKPG: Invalid argument
error adding partition 7


livecd ~ # ls /dev/mapper/
control  dmhda

FAIL: partx detects the partitions but is unable to add a partition.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
