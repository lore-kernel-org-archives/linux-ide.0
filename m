From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] Possible bug - crash during IDE interface probing.
Date: Sun, 12 Dec 2010 21:55:28 GMT
Message-ID: <201012122155.oBCLtS4S031112@demeter1.kernel.org>
References: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:55838 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab0LLVz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2010 16:55:29 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id oBCLtSVX031113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 12 Dec 2010 21:55:28 GMT
In-Reply-To: <bug-24702-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702





--- Comment #2 from software+linux-kernel@kd6lvw.ampr.org  2010-12-12 21:55:27 ---
How do I upgrade?  I download the entire source and unpack it into its own
directory separate from any prior source.  I do NOT patch.  Therefore, there
are no stale object files.  The only component carried from one subversion to
another is the configuration file.  As for include files installed into
/usr/include, I update but I don't permit deletions.  Installation script:

----------------------------------------------------
#!/bin/sh
gunzip -c /proc/config.gz >.config
make menuconfig bzImage modules modules_install
make headers_install INSTALL_HDR_PATH=/tmp ; rm `find /tmp/include -size 0`
(cd /boot ; for x in .config bzImage System.map ; do mv -v $x $x.old ; done)
cp -v .config System.map arch/x86/boot/bzImage /boot
cp -R /tmp/include /usr ; rm -r /tmp/include
exec lilo
----------------------------------------------------
As noted, there is no OOPS message.  It simply dies:

...
Uniform Multi-Platform E-IDE driver
sis5513 0000:00:00.1: SiS730 ATA 100 (1st gen) controller
sis5513 0000:00:00.1: IDE controller (0x1039:0x5513 rev 0xd0)
sis5513 0000:00:00.1: IDE port disabled
sis5513 0000:00:00.1: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07

=>  2.6.36.2 dies here.  2.6.36.1 continues:

Probing IDE interface ide0...
hda: MAXTOR STM3500630A, ATA DISK drive
hdb: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
...
(The above was copied from the 2.6.31.1 syslog.)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
