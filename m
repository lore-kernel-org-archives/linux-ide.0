From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 4/4] implement PMP support, take 4
Date: Tue, 03 Jul 2007 18:34:00 +0900
Message-ID: <468A1808.6070303@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com> <20070703073953.GA5343@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:41504 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbXGCJfS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 05:35:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2685964wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 02:35:18 -0700 (PDT)
In-Reply-To: <20070703073953.GA5343@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Hey,

Jim Paris wrote:
> There are errors with ata1.05 and ata2.05.  I guess those are the
> SiI4726 management ports that were just ignored in the last take of
> PMP.  The EH on those causes a boot delay, but it's pretty short.

Argh... It isn't supposed to fail.  libata-pmp contains workarounds for
those ports now.

>> * Sil4726 is a bit too quirky.  Without the first fan-out port
>>   occupied, the thing acts really weirdly.  As long as the first port
>>   is occupied, it works okay.  This is reportedly fixed by new
>>   firmware.  I tried to update the firmware but installing 3124 driver
>>   on Windows was just too difficult for me and I gave up after thirty
>>   painful minutes.  Anyone up for testing?
> 
> I'll test the 4726 behavior with pulling disks etc including the first
> port.  I'll also search to see if I can find a Windows machine to
> update the firmware and let you know how things change.
> 
> There's a 4726 firmware update utility for Linux available:
>   http://www.siliconimage.com/support/downloadresults.aspx?pid=74
> It's closed source, but I wonder how it is supposed to work.  It seems
> to just probe /dev/sd* and read the first sector.  Maybe it wants that
> management port to be exposed as a SCSI device?

That only works with their proprietary driver ATM.  I'm talking with
SIMG to make it work with the upstream driver.

> [   53.331253] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 6 ports, feat 0x9/0xb

Oh well, this is the first time I see r0.

> [   63.749131] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   63.764490] ata1.05: limiting SATA link speed to 1.5 Gbps
> [   63.764537] ata1.05: limiting speed to UDMA7:PIO5
> [   63.764582] ata1: failed to recover some devices, retrying in 5 secs

If the Config Disk device can't stand IDENTIFY.  I suppose we're better
off disabling last two ports on r0.  I'll ask SIMG about it and add
quirks for r0.

Thanks for testing.

-- 
tejun
