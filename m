From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Subject: Marvell 88SE9320 SATA controller failure during heavy load
Date: Sun, 11 Jan 2015 13:32:30 +0100
Message-ID: <CAPRPZsAZ1n0pd6kviJ5E8C6gV3RGECEZYGQx=485wysS_OYcxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36699 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbAKMca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2015 07:32:30 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so14962871qcx.13
        for <linux-ide@vger.kernel.org>; Sun, 11 Jan 2015 04:32:30 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am using 4x 3TB WD HDDs (WD30EFRX-68EUZN0) on a HighPoint 640L board
with Marvell 88SE9230 AHCI SATA controller. I am using btrfs in RAID5
on these drives. Large copy operations to the disks work fine.
Scrubbing the 4-drive array afterwards reveals 0 errors.

However, when a SMART command is issued during the transfers,
occasionally the following error occurs:

[255341.597723] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[255341.597882] ata7.00: failed command: SMART
[255341.597974] ata7.00: cmd b0/d1:01:01:4f:c2/00:00:00:00:00/00 tag
18 pio 512 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[255341.598227] ata7.00: status: { DRDY }
[255341.598307] ata7: hard resetting link
[255341.917587] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[255341.919688] ata7.00: configured for UDMA/133
[255341.919773] ata7: EH complete

This happens primarily on ata7 but also on ata10 (the 4th drive on the
4-port board). The only other failing command I observed is IDENTIFY
DEVICE. I issued both:

$ sudo smartctl -a /dev/sde

and

$ sudo hddtemp /dev/sde

to trigger these.

Disk activity to the array (the copy operation) suspends completely
until 'EH complete'.  After the incident, the copy operations continue
as if nothing happened. Scrub is also fine. But if I hammer the array
with:

$ for i in {1..10}; do sudo smartctl -a /dev/sde; done

eventually NCQ is also disabled:

[255406.661724] ata7.00: NCQ disabled due to excessive errors
[255406.661745] ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[255406.661894] ata7.00: failed command: IDENTIFY DEVICE
[255406.662000] ata7.00: cmd ec/00:01:00:00:00/00:00:00:00:00/00 tag
10 pio 512 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[255406.662253] ata7.00: status: { DRDY }
[255406.662333] ata7: hard resetting link
[255406.989862] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[255406.992147] ata7.00: configured for UDMA/133
[255406.992256] ata7: EH complete

The driver in use is ahci and the kernel version is 3.18 (on Ubuntu
14.10 server).

I found two reports of a comparable issue at

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=700975 and
https://www.centos.org/forums/viewtopic.php?f=15&t=48964

but in my case the storage system does not break down entirely. People
simply resorted to using another controller and none of the two
reports were eventually solved. Though I normally do not use SMART, I
feel uneasy at the prospect of having to rely on a drive array that is
known to have failed hard once.


Thanks for any advice,


Jeroen.
