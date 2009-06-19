From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Fri, 19 Jun 2009 04:37:26 GMT
Message-ID: <200906190437.n5J4bQ5p010378@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48590 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbZFSEhX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jun 2009 00:37:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5J4bQai010379
	for <linux-ide@vger.kernel.org>; Fri, 19 Jun 2009 04:37:26 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #37 from Stan Senuta Jr. <ssenuta@dialup.cc>  2009-06-19 04:37:25 ---
I compiled kernel-2.6.30 from the tarball using the .config file from my
kernel-2.6.29 & the "Make olddconfig" option. 
Kernel-2.6.29 was also compiled from source. I don't like Mandriva kernels
because they require you to use an initrd.

The only new configuration option I added to kernel-2.6.30  was to keep the
default journal_data=ordered. I did this
because I also run mandriva-2008.0 EXT3 on this "ASUS" box & It would only boot
to ro failsafe mode unless I did this. 
I discovered that w/o journal_data=ordered, the rootfs is 1st mounted ro with
journal_data=writeback & then couldn't 
get "re-mounted" rw with journal_data=ordered because changing the journal at
re-mount isn't permitted by the kernel.

Another oddity I ran into was that kernel-2.6.30  built under Mandriva-2009.1
EXT4 was not usable under an EXT3 filesystem. 
I had to compile kernel-2.6.30 for EXT3 Mandriva-2008.0 seperately or no
modules would load.  

I am attaching a photo (crash.jpeg) of my init 3 screen after I inserted a
dvd-rw disc formated iso9660  & it crashed. 
Please note, I didn't even attempt to mount this disc. The DVD_ROM drive "HDD"
just crashes the system when a formated disc 
or movie disc is detected.

I also am attaching a copy of my dmesg file because /var/log/boot.log is an
empty file on my system. I hope that will help.

______________________________________________________________________________________________
Here is my partition setup:

Disk /dev/hda: 80.0 GB, 80026361856 bytes
16 heads, 63 sectors/track, 155061 cylinders
Units = cylinders of 1008 * 512 = 516096 bytes
Disk identifier: 0x06a2e5a5

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1       58920    29695648+  83  Linux
/dev/hda2           58921      118855    30207240    5  Extended
/dev/hda3          118856      155061    18247824   83  Linux
/dev/hda5           58921       59935      511528+  82  Linux swap / Solaris
/dev/hda6           59936      118855    29695648+  83  Linux

Disk /dev/sda: 250.0 GB, 250059350016 bytes
255 heads, 63 sectors/track, 30401 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Disk identifier: 0x6fb3f3d0

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1           7       56196   83  Linux
/dev/sda2               8        7841    62926605   83  Linux
/dev/sda3            7842       15936    65023087+   5  Extended
/dev/sda4           15937       30401   116190112+  83  Linux
/dev/sda5            7842        8103     2104483+  82  Linux swap / Solaris
/dev/sda6            8104       15936    62918541   83  Linux

[root@localhost stan]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/sda2     ext4     60G  4.2G   52G   8% /         
/dev/sda1     ext3     54M   13M   39M  24% /boot     
/dev/sda6     ext4     60G  3.1G   53G   6% /usr      
/dev/hdc   iso9660    2.4G  2.4G     0 100% /mnt/misc

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
