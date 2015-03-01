From: Felix Miata <mrmazda@earthlink.net>
Subject: please help ID delay source
Date: Sat, 28 Feb 2015 21:51:40 -0500
Message-ID: <54F27EBC.1000309@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:35617 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993AbbCADCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Feb 2015 22:02:04 -0500
Received: from [69.22.67.58] (helo=[192.168.0.11])
	by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1YRtyn-0005II-35
	for linux-ide@vger.kernel.org; Sat, 28 Feb 2015 21:51:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm experiencing long delays at bootloader time on one multiboot system
(BIOS; 2 core), but only for some installations.

No delays with these:
openSUSE 13.1 3.12.36
Kubuntu 14.10 3.16.0
Mageia 4 3.18.2
Fedora 21 3.18.7
Fedora 22 3.19.rc4
Fedora 22 3.19.rc7
Rawhide 3.19.rc7
Cauldron 3.19.0
Fedora 22 4.0.0.rc1

For each not producing delay, 80x25 screen shows very briefly, before init
proceeds normally, output in the following form:

root (hd#,##)
 Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz...video=1024x768@60 3
  [Linux-Bz-Image, setup=0x####, size=0x######]
initrd /boot/initrd

For those producing delay, the last line above does not appear until after
the delay expires. The following consistently produce delays:
openSUSE 13.2 3.16.6 (168 seconds)
openSUSE 13.2 3.16.7 (169 seconds)
openSUSE Tumbleweed 3.19.0 (174 seconds)
Rawhide 4.0.0.rc1 (104 seconds)

>From what I can tell from output from smart and hdparm, the HD is not the
source of delay:
http://fm.no-ip.com/Tmp/Linux/Boot/hdparmdata-big41-test.txt

All installations are normally booted using the same Grub on /dev/sda3, using
identical syntax, so their cmdlines all look about the same except for the
root= parameter. Instead chainloading to the installed bootloader on each /
filesystem has no impact on delays that I have as yet noticed. This system
has been normally functional more than 30 months with same HD. The delays
started only recently, though whether as much as a week or a month since
delays started I cannot recall.

Output from journalctl -k -b from each installation above (except Kubuntu)
can be found here:
http://fm.no-ip.com/Tmp/Linux/Boot/

Any ideas how to locate the fault?
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
