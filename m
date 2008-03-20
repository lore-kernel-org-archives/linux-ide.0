From: "davor emard" <davoremard@gmail.com>
Subject: AHCI SATA DVD writing issue
Date: Thu, 20 Mar 2008 12:16:58 +0100
Message-ID: <beee72200803200416j2c744450v8b21cf6fe029ff1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:14257 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbYCTLRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 07:17:00 -0400
Received: by py-out-1112.google.com with SMTP id u52so1145785pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 04:16:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

HI
I've seen your mail in kernel ahci.c and I'm not sure if I addressed
the right place to report thos but you are my starting point :-)

I have sata dvd writer issues. Have tried pioneer dvr215 and optiarc 7173S
connected on intel and marvell 6145 port. I updated the motherboard
bios (that has some marvell firmware onboard) up to the latest.
marvell sata port gave me the better results but not too good
both sata's are ahci compliant, so using ahci.c driver in kernel.

I compiled 2.6.24.3 on amd64 but the similar problems existed even before
on earlier kernels from 2.6.20 when when I started trying with this
and now I think It's my duty to start reporting this at last

I tried scsi cdrom with and without support for vendor-specific ioctls
doesn't matter

On intel sata hardware I cannot flash optiarc drive from linux
(drive not detected).

On marvell 6145 sata flashing works to the optiarc drive
(program autodetects the drive from sg and sr-mod driver).
Flash program on linux also detects the pioneer but the linux
flashing support is not stable to this program so I haven't tried it

I can also write correct iso image from pioneer and optiarc using
growisofs -Z /dev/scd0=image.iso
I can mount the disc with pioneer
mount /dev/scd0 /mnt and it works
I cannot do the mount with optiarc, mount waits a long
time and in kernel log appears something like

Mar 19 01:18:32 emard kernel: ata6.00: exception Emask 0x0 SAct 0x0
SErr 0x0 action 0x2 f
Mar 19 01:18:32 emard kernel: ata6.00: cmd
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio
Mar 19 01:18:32 emard kernel: cdb ac 00 00 00 00 00 00 00 00
01 03 00 00 00 00
Mar 19 01:18:32 emard kernel: res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4
Mar 19 01:18:32 emard kernel: ata6.00: status: { DRDY }

and once this appears, both optiarc and pioneer connected refuse
to work with messages like

Mar 19 01:18:32 emard kernel: ata6: hard resetting link
Mar 19 01:18:34 emard kernel: ata6: failed to reset engine (errno=-5)
Mar 19 01:18:34 emard kernel: ata6: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Mar 19 01:19:04 emard kernel: ata6.00: qc timeout (cmd 0xa1)
Mar 19 01:19:04 emard kernel: ata6.00: failed to IDENTIFY (I/O error,
err_mask=0x4)
Mar 19 01:19:04 emard kernel: ata6.00: revalidation failed (errno=-5)
Mar 19 01:19:04 emard kernel: ata6: failed to recover some devices,
retrying in 5 secs
Mar 19 01:19:09 emard kernel: ata6: hard resetting link

I need to reboot to get them "working" again

Also using the dvd from wodim is particularly very broken.
if I try to autodetect pionner
wodim dev=/dev/scd0 -scanbus
it will produce in the log something like

Mar 19 01:18:32 emard kernel: ata6.00: exception Emask 0x0 SAct 0x0
SErr 0x0 action 0x2 f
Mar 19 01:18:32 emard kernel: ata6.00: cmd
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio
Mar 19 01:18:32 emard kernel: cdb ac 00 00 00 00 00 00 00 00
01 03 00 00 00 00
Mar 19 01:18:32 emard kernel: res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4
Mar 19 01:18:32 emard kernel: ata6.00: status: { DRDY }

and after a long time, wodim will even print correct device and
capabilities of pioneer, but nothing else on sata will work from
this point (unless I reboot again).

Any following wodim dev=/dev/scd0 -scanbus
will report nothing and of course drives will not work from this point on

if I use wodim to autodetect optiarc
wodim dev=/dev/scd1 -scanbus
then it will report above sata exception but after some shorter
pause then drive will be correctly detected with wodim gives me
a hard scsi error report, but the drive will continue being autodetectable
so following wodim dev=/dev/scd1 -scanbus will again report the optiarc
device correctly

What do you say, is it easy to get rid of this ata exception errors that
hose up the sata bus?

Best regards, Davor
