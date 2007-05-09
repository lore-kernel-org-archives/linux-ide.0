From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Wed, 09 May 2007 19:37:31 +0200
Message-ID: <464206DB.1010506@t-online.de>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de> <464088BF.5070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout05.sul.t-online.com ([194.25.134.82]:58084 "EHLO
	mailout05.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755850AbXEIRhp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 13:37:45 -0400
In-Reply-To: <464088BF.5070106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

Hi Tejun,

Sorry to say, but after applying your patch it still doesn't work.

If I insert the DVD and wait before running xine, then I can watch
it. But if I keep the tray open and run xine, then xine closes
the tray. It gets stuck for some time, and then I get

% xine dvd:/dev/scd0
This is xine (X11 gui) - a free video player v0.99.5cvs.
(c) 2000-2006 The xine Team.
libdvdread: Using libdvdcss version 1.2.9 for DVD access
libdvdread: Could not open /dev/scd0 with libdvdcss.
libdvdread: Can't open /dev/scd0 for reading


kern.log says:

May  9 19:11:57 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
May  9 19:11:57 pluto kernel: ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xa4 data 12 in
May  9 19:11:57 pluto kernel:          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
May  9 19:11:57 pluto kernel: ata2: soft resetting port
May  9 19:12:05 pluto kernel: ata2: port is slow to respond, please be patient (Status 0xf8)
May  9 19:12:28 pluto kernel: ata2: port failed to respond (30 secs, Status 0xf8)
May  9 19:12:28 pluto kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May  9 19:12:28 pluto kernel: ATA: abnormal status 0xF8 on port 0xffffc2000001a0c7
May  9 19:12:28 pluto last message repeated 5 times
May  9 19:12:58 pluto kernel: ata2.00: qc timeout (cmd 0xa1)
May  9 19:12:58 pluto kernel: ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
May  9 19:12:58 pluto kernel: ata2.00: revalidation failed (errno=-5)
May  9 19:12:58 pluto kernel: ata2: failed to recover some devices, retrying in 5 secs
May  9 19:13:03 pluto kernel: ata2: hard resetting port
May  9 19:13:03 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May  9 19:13:03 pluto kernel: ata2.00: XXX: IDENTIFY
May  9 19:13:03 pluto kernel: 00: 85c0 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 08: 0000 0000 2020 2020  2020 2020 2020 2020
May  9 19:13:03 pluto kernel: 10: 2020 2020 2020 2020  0000 0000 0000 5342
May  9 19:13:03 pluto kernel: 18: 3032 2020 2020 5453  5354 636f 7270 4344
May  9 19:13:03 pluto kernel: 20: 2f44 5644 5720 5348  2d53 3138 3341 2020
May  9 19:13:03 pluto kernel: 28: 2020 2020 2020 2020  2020 2020 2020 0000
May  9 19:13:03 pluto kernel: 30: 0000 0f00 0000 0200  0200 0006 0000 0000
May  9 19:13:03 pluto kernel: 38: 0000 0000 0000 0000  0000 0000 0000 0007
May  9 19:13:03 pluto kernel: 40: 0003 0078 0078 0078  0078 0000 0000 0000
May  9 19:13:03 pluto kernel: 48: 0000 0000 0000 0000  0602 0000 0068 0040
May  9 19:13:03 pluto kernel: 50: 0000 0000 0000 4000  4000 0000 0000 4000
May  9 19:13:03 pluto kernel: 58: 0407 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 60: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 68: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 70: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 78: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 80: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 88: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 90: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: 98: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: a0: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: a8: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: b0: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: b8: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: c0: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: c8: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: d0: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: d8: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: e0: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: e8: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: f0: 0000 0000 0000 0000  0000 0000 0000 0000
May  9 19:13:03 pluto kernel: f8: 0000 0000 0000 0000  0000 0000 0000 9ca5
May  9 19:13:04 pluto kernel: ata2.00: configured for UDMA/33
May  9 19:13:04 pluto kernel: ata2: EH complete


After that (the DVD is still in) I can rerun xine, and it works.
This is reproducible using CSS DVDs. Using a DVD without CSS there
is no such problem. It takes some time till the DVD is played,
but there is no soft reset.

Using "gmplayer dvd://" I get the same problem.


You told me some time ago that you bought the same drive. Can you
reproduce this problem? Please don't get me wrong, I am glad to
support you by trying out new patches.


Regards

Harri

