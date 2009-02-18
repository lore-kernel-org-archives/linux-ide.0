From: maximilian attems <max@stro.at>
Subject: initramfs-tools 0.93 status report
Date: Wed, 18 Feb 2009 23:23:33 +0100
Message-ID: <20090218222333.GA4440@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:37770 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZBRWXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Feb 2009 17:23:41 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: initramfs@vger.kernel.org
Cc: debian-kernel@lists.debian.org, klibc@zytor.com, Matthew Wilcox <willy@linux.intel.com>, linux-ide@vger.kernel.org


initramfs-tools git repo:
git clone git://git.debian.org/kernel/initramfs-tools.git

initramfs-tools is an hookable initramfs generator.
It can boot on NFS, LVM2, md, LUKS, dmraid, oldstyle devices, ..
The generated initramfs is generic, but can explicitly be tuned for small.
It is actively deployed in Debian and Ubuntu. It is written in POSIX shell.
It has an "end-user" friendly invocation with update-initramfs and the low
level mkinitramfs. klibc is used for minimal initramfs. The initramfs
comes together with a rescue shell. It is possible to ssh into it.
run-init nukes initramfs, remounts /root, chroots, spawns init.

It may currently be distro specific as many Debian packages ship hooks
for it (udev, mdadm, cryptsetup, lvm2, ..). But it should be quite easy
to make it non distro specific and fix debianism (add a rpm spec, ..).

initramfs-tools is badly hit on the linux-2.6 side by races due to
SCSI_WAIT_SCAN being implemented only in some scsi drivers and
not at all on usb and scsi side.  willy had this patch to fix it:
http://www.parisc-linux.org/~willy/libata-async-2.diff


0.93 features:
- OLPC support
- hid_* modules addition
- fixes for MODULES=dep high minor partitions and Xen virtual block dev
- make deb-pkg linux-2.6 target support
- find, cpio exit codes no longer ignored
- fixes for LABEL strings with '/' 
- misc cleanups
- doc fixes


TODO:
- monolithical linux support
- MODULES=dep special case raid on top of lvm
- mawk support??
- loopback fs support (ubuntu merge)
- mount failure hooks (ubuntu merge)
- fix bugs http://bugs.debian.org/src:initramfs-tools


thanks for hacking on it, sending in patches advices or whatever.

-- 
maks

