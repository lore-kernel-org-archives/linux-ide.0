From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Mon, 07 May 2007 12:29:28 +0200
Message-ID: <463EFF88.7050308@gmail.com>
References: <46362672.7080103@gmx.net> <4636EA85.40809@t-online.de> <46371628.9060905@gmail.com> <46379CA1.601@t-online.de> <463AEAF9.3000103@gmail.com> <463B6E3F.5000300@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020206020905010009090404"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:52372 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbXEGK3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 06:29:40 -0400
Received: by py-out-1112.google.com with SMTP id a29so1144272pyi
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 03:29:40 -0700 (PDT)
In-Reply-To: <463B6E3F.5000300@t-online.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-ide@vger.kernel.org, Daniel Beichl <daniel_beichl@gmx.net>

This is a multi-part message in MIME format.
--------------020206020905010009090404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, Harald.

Harald Dunkel wrote:
> If I enter a movie DVD into my drive (Samsung SH-S183A, SATA)
> and run xine dvd:/dev/scd0 immediately (while the drive's LED
> is still blinking), then there is some timeout problem.
> kern.log says:
> 
> May  4 19:10:17 pluto kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr
> 0x0 action 0x2 frozen
> May  4 19:10:17 pluto kernel: ata2.00: cmd
> a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xa4 data 8 in
> May  4 19:10:17 pluto kernel:          res
> 40/00:02:00:04:08/00:00:00:00:00/a0 Emask 0x4 (timeout)
> May  4 19:10:17 pluto kernel: ata2: soft resetting port
> May  4 19:10:24 pluto kernel: ata2: port is slow to respond, please be
> patient (Status 0xf8)
> May  4 19:10:47 pluto kernel: ata2: port failed to respond (30 secs,
> Status 0xf8)
> May  4 19:10:47 pluto kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
> SControl 310)
> May  4 19:10:47 pluto kernel: ATA: abnormal status 0xF8 on port
> 0xffffc2000001a0c7
> May  4 19:10:47 pluto last message repeated 5 times
> May  4 19:11:17 pluto kernel: ata2.00: qc timeout (cmd 0xa1)
> May  4 19:11:17 pluto kernel: ata2.00: failed to IDENTIFY (I/O error,
> err_mask=0x4)
> May  4 19:11:17 pluto kernel: ata2.00: revalidation failed (errno=-5)
> May  4 19:11:17 pluto kernel: ata2: failed to recover some devices,
> retrying in 5 secs
> May  4 19:11:22 pluto kernel: ata2: hard resetting port
> May  4 19:11:23 pluto kernel: CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2:
> SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> May  4 19:11:23 pluto kernel: ata2.00: XXX: IDENTIFY
> May  4 19:11:23 pluto kernel: 00: 85c0 0000 0000 0000  0000 0000 0000 0000
[--snip--]
> May  4 19:11:23 pluto kernel: ata2.00: configured for UDMA/33
> May  4 19:11:23 pluto kernel: ata2: EH complete

The above is slightly different from the last one in that the device
times out the following IDENTIFY command instead of sending corrupt
data.  The last log looked like...

 ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
 ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0xad data 2052 in
          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
 ata2: soft resetting port
 CLASSIFY TF 00/01:01:01:14:eb/a0 <6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
 ata2.00: revalidation failed (errno=-22)
 ata2.00: disabled
 ata2: EH complete

Note how the device is offlined after the error because it reported
the wrong IDENTIFY data wheras IDENTIFY timeout was recovered properly
(you can still access the device after the EH is complete).

> Its pretty much reproducible. For the example above the DVD played
> at the end, but sometimes the DVD drive dies, and I have to reboot.
> 
> If I enter a data DVD and try to mount it without waiting, then I get
> 
> % mount /cdrom
> mount: /dev/scd0 already mounted or /cdrom busy
> % mount /cdrom
> %
> 
> There is no message in kern.log in this case. On the second try it
> succeeds, as shown above.

This is probably because xine is opening the dvd device with
O_NONBLOCK set.  That tells the cdrom driver to skip
readiness/integrity check.  If it sets O_NONBLOCK, it's the
application's responsibility to perform readiness check but it seems
xine skips that and just issue REPORT KEY, which times out as the
device takes more time to recognize the media than the specified
timeout and kicks EH into action.

Please report the result of...

$ strace xine <whatever you need to play dvd> > out 2>&1

> If I enter a data DVD without running anything, then it takes
> about 15 seconds till the LED goes off. Movie DVDs are a little
> bit faster: 12 secs. But I am sure this depends.

I think the waiting itself isn't a bug in the driver.  It seems that
the particular device needs a tad bit more time to recognize what's in
it and xine seems to be not testing for device readiness before
issuing other commands (needs verification tho).

What I'm primarily concerned about is the device getting disabled due
to corrupt IDENTIFY data.  Can you test whether the attached patch
fixes the device disabling?

Thanks.

-- 
tejun

--------------020206020905010009090404
Content-Type: text/x-patch;
 name="give-one-last-chance-on-EINVAL.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="give-one-last-chance-on-EINVAL.patch"


--------------020206020905010009090404--
