From: "business.kid" <business.kid@gmail.com>
Subject: Recent kernel hosing partition
Date: Sun, 2 Dec 2007 12:02:31 -0800 (PST)
Message-ID: <14119388.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:33259 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbXLBUCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 15:02:33 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Iyv1L-0008B5-Ty
	for linux-ide@vger.kernel.org; Sun, 02 Dec 2007 12:02:31 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Since the update to the 2.6.23.1-21.fc7 kernel, I have been getting weird
errors on the disk (see attached).  Fedora's stock kernels use the new
driver exclusively.

Disk action never recovers - maybe Ctrl_alt_Backspace or Ctrl_alt_del
restores unfreezes. Switch off otherwise. While these are going on, chaos
reigns on the disk. E2fsck passes were required. Now lost+found on hda3
(Fedora 7) is 41 Megs! The disk and partition have been in use for less than
2 months. The other partitions are fine, The disk is an ST380215A 80Gig
configured
sda1: Common boot
sda2:swap
sda3: Fedora 7 / Now with 41 Megs in lost+found
sda4 extended partition
sda5 Fedora 7 /home.
sda6 fc5
sda7 hlfs-20051220
sda8, 9 : Kevux installations in various states.

I'm blaming software, and, to put it in Royal parlance, I am 'Not amused'.
The box has an Athlon 2.6Ghz, 1 gig of ram, Via Kt-400 chipset & old nvidia
card - the sort they give away in breakfast cereal boxes (MX-440) This
problem is worst in X, with firefox running. Most of that is now in
lost+found, including /usr/lib/firefox<version>. X starts but gnome is hosed
(black screen, a couple of lifeless icons pointing at files which have found
their way to lost+found). Wine is also awol

Is this a known issue? Where do I report it? Any ideas to avoid a repeat
http://www.nabble.com/file/p14119388/sda.txt sda.txt 
-- 
View this message in context: http://www.nabble.com/Recent-kernel-hosing-partition-tf4933013.html#a14119388
Sent from the linux-ide mailing list archive at Nabble.com.

