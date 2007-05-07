From: Harald Dunkel <harald.dunkel@t-online.de>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Mon, 07 May 2007 20:21:57 +0200
Message-ID: <463F6E45.504@t-online.de>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout06.sul.t-online.com ([194.25.134.19]:55769 "EHLO
	mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934487AbXEGSWI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 14:22:08 -0400
In-Reply-To: <463EFF88.7050308@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

Hi Tejun,

Your last patch contained zero bytes. Please check.

Tejun Heo wrote:
> 
> Please report the result of...
> 
> $ strace xine <whatever you need to play dvd> > out 2>&1
> 

out.gz is >400KByte compressed. See private EMail. Below is
the output in kern.log. This time it is the correct output
(hopefully). After this the drive was unaccessible.


Regards

Harri
=============================================================
May  7 20:16:10 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
May  7 20:16:10 pluto kernel: ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xad data 2052 in
May  7 20:16:10 pluto kernel:          res 40/00:00:00:10:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
May  7 20:16:10 pluto kernel: ata2: soft resetting port
May  7 20:16:10 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
May  7 20:16:10 pluto kernel: ata2.00: XXX: IDENTIFY
May  7 20:16:10 pluto kernel: 00: 6d58 2c35 985e 35e8  5e2c e898 2c35 985e
May  7 20:16:10 pluto kernel: 08: 35e8 5e2c c8b8 0c15  b87e 15c8 7e0c c8b8
May  7 20:16:10 pluto kernel: 10: 0c15 b87e 15c8 7e0c  e898 2c35 985e 66aa
May  7 20:16:10 pluto kernel: 18: 6e1e c8b8 0c15 cc0d  66bc 3d43 9ae8 6f71
May  7 20:16:10 pluto kernel: 20: b71a 63ac 090c bbd0  0166 a966 06a9 7e0c
May  7 20:16:10 pluto kernel: 28: c8b8 0c15 b87e 15c8  7e0c c8b8 0c15 985e
May  7 20:16:10 pluto kernel: 30: 35e8 512c e898 2e35  9a5e 35ee 5e2c e898
May  7 20:16:10 pluto kernel: 38: 2c35 985e 35e8 5e2c  e898 2c35 985e 35ef
May  7 20:16:10 pluto kernel: 40: 5e2f e8e0 2c4d 9826  3590 5e2c e898 2c35
May  7 20:16:10 pluto kernel: 48: 985e 35e8 5e2c e898  2a37 985e 3580 5e6c
May  7 20:16:10 pluto kernel: 50: e898 2c35 985e 75e8  1e2c e898 2c35 d85e
May  7 20:16:10 pluto kernel: 58: 31ef 5e2c e898 2c35  985e 35e8 5e2c e898
May  7 20:16:10 pluto kernel: 60: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
May  7 20:16:10 pluto kernel: 68: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
May  7 20:16:10 pluto kernel: 70: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
May  7 20:16:10 pluto kernel: 78: e898 2c35 985e 35e8  5e2c e898 2c35 985e
May  7 20:16:10 pluto kernel: 80: 35e8 5e2c e898 2c35  985e 35e8 5e2c e898
May  7 20:16:10 pluto kernel: 88: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
May  7 20:16:10 pluto kernel: 90: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
May  7 20:16:10 pluto kernel: 98: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
May  7 20:16:10 pluto kernel: a0: e898 2c35 985e 35e8  5e2c e898 2c35 985e
May  7 20:16:10 pluto kernel: a8: 35e8 5e2c e898 2c35  985e 35e8 5e2c e898
May  7 20:16:10 pluto kernel: b0: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
May  7 20:16:10 pluto kernel: b8: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
May  7 20:16:10 pluto kernel: c0: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
May  7 20:16:10 pluto kernel: c8: e898 2c35 985e 35e8  5e2c e898 2c35 985e
May  7 20:16:10 pluto kernel: d0: 35e8 5e2c e898 2c35  985e 35e8 5e2c e898
May  7 20:16:10 pluto kernel: d8: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
May  7 20:16:10 pluto kernel: e0: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
May  7 20:16:10 pluto kernel: e8: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
May  7 20:16:10 pluto kernel: f0: e898 2c35 985e 35e8  5e2c e898 2c35 985e
May  7 20:16:10 pluto kernel: f8: 35e8 5e2c e898 2c35  985e 35e8 5e2c 743d
May  7 20:16:10 pluto kernel: ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
May  7 20:16:10 pluto kernel: ata2.00: revalidation failed (errno=-22)
May  7 20:16:10 pluto kernel: ata2.00: disabled
May  7 20:16:11 pluto kernel: ata2: EH complete
May  7 20:16:11 pluto kernel: cdrom: This disc doesn't have any tracks I recognize!
May  7 20:16:48 pluto kernel: Buffer I/O error on device sr0, logical block 0
May  7 20:16:48 pluto kernel: Buffer I/O error on device sr0, logical block 1
:
:

