From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Tue, 08 May 2007 16:27:11 +0200
Message-ID: <464088BF.5070106@gmail.com>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de> <463EFF88.7050308@gmail.com> <463F6E45.504@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020600050402000507000905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:24474 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967710AbXEHO11 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 10:27:27 -0400
Received: by py-out-1112.google.com with SMTP id a29so1494965pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 07:27:26 -0700 (PDT)
In-Reply-To: <463F6E45.504@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

This is a multi-part message in MIME format.
--------------020600050402000507000905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Harald Dunkel wrote:
> Hi Tejun,
> 
> Your last patch contained zero bytes. Please check.

Sorry, new patch attached.

> Tejun Heo wrote:
>>
>> Please report the result of...
>>
>> $ strace xine <whatever you need to play dvd> > out 2>&1
>>
> 
> out.gz is >400KByte compressed. See private EMail. Below is
> the output in kern.log. This time it is the correct output
> (hopefully). After this the drive was unaccessible.

Thanks.  xine was opening it the regular way.  Can't tell why it times
out.  :(

> =============================================================
> May  7 20:16:10 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2 frozen
> May  7 20:16:10 pluto kernel: ata2.00: cmd
> a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xad data 2052 in
> May  7 20:16:10 pluto kernel:          res
> 40/00:00:00:10:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> May  7 20:16:10 pluto kernel: ata2: soft resetting port
> May  7 20:16:10 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2:
> SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> May  7 20:16:10 pluto kernel: ata2.00: XXX: IDENTIFY
> May  7 20:16:10 pluto kernel: 00: 6d58 2c35 985e 35e8  5e2c e898 2c35 985e
> May  7 20:16:10 pluto kernel: 08: 35e8 5e2c c8b8 0c15  b87e 15c8 7e0c c8b8
> May  7 20:16:10 pluto kernel: 10: 0c15 b87e 15c8 7e0c  e898 2c35 985e 66aa
> May  7 20:16:10 pluto kernel: 18: 6e1e c8b8 0c15 cc0d  66bc 3d43 9ae8 6f71
> May  7 20:16:10 pluto kernel: 20: b71a 63ac 090c bbd0  0166 a966 06a9 7e0c
> May  7 20:16:10 pluto kernel: 28: c8b8 0c15 b87e 15c8  7e0c c8b8 0c15 985e
> May  7 20:16:10 pluto kernel: 30: 35e8 512c e898 2e35  9a5e 35ee 5e2c e898
> May  7 20:16:10 pluto kernel: 38: 2c35 985e 35e8 5e2c  e898 2c35 985e 35ef
> May  7 20:16:10 pluto kernel: 40: 5e2f e8e0 2c4d 9826  3590 5e2c e898 2c35
> May  7 20:16:10 pluto kernel: 48: 985e 35e8 5e2c e898  2a37 985e 3580 5e6c
> May  7 20:16:10 pluto kernel: 50: e898 2c35 985e 75e8  1e2c e898 2c35 d85e
> May  7 20:16:10 pluto kernel: 58: 31ef 5e2c e898 2c35  985e 35e8 5e2c e898
> May  7 20:16:10 pluto kernel: 60: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
> May  7 20:16:10 pluto kernel: 68: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
> May  7 20:16:10 pluto kernel: 70: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
> May  7 20:16:10 pluto kernel: 78: e898 2c35 985e 35e8  5e2c e898 2c35 985e
> May  7 20:16:10 pluto kernel: 80: 35e8 5e2c e898 2c35  985e 35e8 5e2c e898
> May  7 20:16:10 pluto kernel: 88: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
> May  7 20:16:10 pluto kernel: 90: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
> May  7 20:16:10 pluto kernel: 98: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
> May  7 20:16:10 pluto kernel: a0: e898 2c35 985e 35e8  5e2c e898 2c35 985e
> May  7 20:16:10 pluto kernel: a8: 35e8 5e2c e898 2c35  985e 35e8 5e2c e898
> May  7 20:16:10 pluto kernel: b0: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
> May  7 20:16:10 pluto kernel: b8: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
> May  7 20:16:10 pluto kernel: c0: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
> May  7 20:16:10 pluto kernel: c8: e898 2c35 985e 35e8  5e2c e898 2c35 985e
> May  7 20:16:10 pluto kernel: d0: 35e8 5e2c e898 2c35  985e 35e8 5e2c e898
> May  7 20:16:10 pluto kernel: d8: 2c35 985e 35e8 5e2c  e898 2c35 985e 35e8
> May  7 20:16:10 pluto kernel: e0: 5e2c e898 2c35 985e  35e8 5e2c e898 2c35
> May  7 20:16:10 pluto kernel: e8: 985e 35e8 5e2c e898  2c35 985e 35e8 5e2c
> May  7 20:16:10 pluto kernel: f0: e898 2c35 985e 35e8  5e2c e898 2c35 985e
> May  7 20:16:10 pluto kernel: f8: 35e8 5e2c e898 2c35  985e 35e8 5e2c 743d
> May  7 20:16:10 pluto kernel: ata2.00: failed to IDENTIFY (device

Yeap, this is what I was talking about.  The whole IDENTIFY area seems
to contain repeating pattern.  Probably something to do with unflushed
FIFO.  The attached patch should allow EH to recover properly from this.
 Please test.

Thanks.

-- 
tejun

--------------020600050402000507000905
Content-Type: text/x-patch;
 name="give-one-last-chance-on-EINVAL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="give-one-last-chance-on-EINVAL.patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2bff9ad..82b212f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2177,14 +2177,10 @@ static int ata_eh_recover(struct ata_por
 	ehc->tries[dev->devno]--;
 
 	switch (rc) {
-	case -EINVAL:
-		/* eeek, something went very wrong, give up */
-		ehc->tries[dev->devno] = 0;
-		break;
-
 	case -ENODEV:
 		/* device missing or wrong IDENTIFY data, schedule probing */
 		ehc->i.probe_mask |= (1 << dev->devno);
+	case -EINVAL:
 		/* give it just one more chance */
 		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
 	case -EIO:

--------------020600050402000507000905--
