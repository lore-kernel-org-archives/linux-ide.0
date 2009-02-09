From: Grant Grundler <grundler@google.com>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 9 Feb 2009 01:26:11 -0800
Message-ID: <da824cf30902090126p5e031e09q5b93da7a296bc849@mail.gmail.com>
References: <498F42B6.8030607@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:42866 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZBIJ0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 04:26:17 -0500
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id n199QEIw019268
	for <linux-ide@vger.kernel.org>; Mon, 9 Feb 2009 09:26:14 GMT
Received: from rv-out-0506.google.com (rvbk40.prod.google.com [10.140.87.40])
	by wpaz33.hot.corp.google.com with ESMTP id n199QB77016402
	for <linux-ide@vger.kernel.org>; Mon, 9 Feb 2009 01:26:12 -0800
Received: by rv-out-0506.google.com with SMTP id k40so12396192rvb.57
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2009 01:26:11 -0800 (PST)
In-Reply-To: <498F42B6.8030607@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-ide@vger.kernel.org

Linda,
Please tell us which kernel version you have and include the dmesg
output. Port multiplier support is generally working in 2.6.26 (and later
releases) for several drivers.  PM support was added after 2.6.20.

Where did you find 350MB/s theoretical?
Link is 8b10b encoded. So it's 10:1 of bits to bytes conversion of link rate.
3Gb/s --> 300MB/s in theory.

For MB/s, it depends on the SATA controller. Don't expect more then
225-235 MB/s per port. At least one sata_sil3124 chip (3126?) is buggy
and won't do more than 120MB/s read for all ports (170 MB/s write).
See linux-ide archives for discussion on this.

On Feb 8, 2009 1:08 PM, "Linda Walsh" <lkml@tlinx.org> wrote:

Is there something different, from normal disk-access, that I need to do
to access hard disks beyond '1', on a port-multiplier?

I thought I remembered reading the port multiplier support was
working for many SATA and SATA RAID controller capable chipsets,
including the Sil 3124.

I picked up a 2-Bay external SATA enclosure that I'm trying to access in
(what I thought) was the simplest mode: "JBOD".  However, when I boot,
I am only seeing the first hard disk.

Experimenting, I tried a single hard disk in both positions -- one
position let me see the disk directly (as though it was a direct,
str8-thru connection), the other position showed up detected by
the boot BIOS as a 7MB HD by some unrecognized vendor.   In
linux, I'm able to access and use the hard disk when it appears
'str8-thru', but linux sees nothing concerning the 7MB pseudo HD.

Is my expectation that the driver would simply recognize the
external enclosure by whatever I had the external enclosure set to,
too optimistic?  Do I need to run some special util to setup the disks in
JBOD mode?  I guess I thought I only needed to worry about
'special utils' if I was using the disk-pair in a RAID config (0/1)...

It seems there should be a linux util to manage the "container",
'sil57xx'  --  I take it is not used for RAID-only config?

My ultimate aim is to use it in a RAID-0, mirror config (my luck
with SATA disk drives has been abysmal, of late (*sigh*)).

Anyone with any real-world experience about when the 3Gb SAS
starts to become a bottleneck?  I know that theoretically, it could
support a hair over 350MB/s if there was no overhead, which would
reliably only support 2 hard disks at full speed (assuming ~120MB/s
max linear read speed/disk).  Does that jive with people's real-world
experience?  I.e. port-multipliers can provide full throughput for
2-HD's but not likely 3?
Should I be looking for an sil57xx program somewhere (the box contained
a mini-CD, but it looks like a driver for an older kernel (2.6.9).
Not so sure about it's usefulness in my setup.

Thanks,
-linda

--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
