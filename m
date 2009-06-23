From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Tue, 23 Jun 2009 04:07:36 GMT
Message-ID: <200906230407.n5N47a1h005135@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42310 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZFWEHe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 00:07:34 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5N47aj1005136
	for <linux-ide@vger.kernel.org>; Tue, 23 Jun 2009 04:07:36 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #44 from Stan Senuta Jr. <ssenuta@dialup.cc>  2009-06-23 04:07:35 ---
I am pleased to report that your kernel-2.6.30 patch
(0001-ide-cd-prevent-null-pointer-deref-via-cdrom_newpc_in.patch) 
fixed the crash problem when accessing my /dev/hdd dvd-rom drive. I was able to
mount a dvd-rw disc & here is the proof:

[root@localhost stan]# mount -t iso9660 /dev/hdd /mnt/misc
mount: block device /dev/hdd is write-protected, mounting read-only
[root@localhost stan]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/sda2     ext4     60G  4.3G   52G   8% /
/dev/sda1     ext3     54M   16M   36M  31% /boot
/dev/sda6     ext4     60G  3.1G   53G   6% /usr
/dev/hdd   iso9660    400K  400K     0 100% /mnt/misc

[root@localhost stan]# mount -t iso9660 /dev/hdc /mnt/cddrive
[root@localhost stan]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/sda2     ext4     60G  4.3G   52G   8% /
/dev/sda1     ext3     54M   16M   36M  31% /boot
/dev/sda6     ext4     60G  3.1G   53G   6% /usr
/dev/hdd   iso9660    400K  400K     0 100% /mnt/misc
/dev/hdc   iso9660    350K  350K     0 100% /mnt/cddrive

I edited the kernel-2.6.30 "ide-cd.c" file as instructed to apply the patch &
then ran the following 
commands to re-compile my kernel:

      make mrproper
      cp .config-save .config
      make oldconfig
      make
      make modules_install

My  "new"  /lib/modules/2.6.30/drivers/ide/ide-cd_mod.ko showed file size =
35133 bytes.
The "orig" /lib/modules/2.6.30/drivers/ide/ide-cd_mod.ko showed file size =
35125 bytes.

I also inserted a commercial video movie disc & a cd-rw disc in problem drive
/dev/hdd.
Everything seems too work fine. Thank you.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
