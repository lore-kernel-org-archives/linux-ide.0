From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 9 Feb 2009 09:35:44 -0500
Message-ID: <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
References: <498F42B6.8030607@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:46497 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZBIOfp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 09:35:45 -0500
Received: by qw-out-2122.google.com with SMTP id 5so63933qwi.37
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2009 06:35:44 -0800 (PST)
In-Reply-To: <498F42B6.8030607@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-ide@vger.kernel.org

On Sun, Feb 8, 2009 at 3:38 PM, Linda Walsh <lkml@tlinx.org> wrote:
> Is there something different, from normal disk-access, that I need to do
> to access hard disks beyond '1', on a port-multiplier?
>
> I thought I remembered reading the port multiplier support was
> working for many SATA and SATA RAID controller capable chipsets,
> including the Sil 3124.
>
> I picked up a 2-Bay external SATA enclosure that I'm trying to access in
> (what I thought) was the simplest mode: "JBOD".  However, when I boot,
> I am only seeing the first hard disk.
>
> Experimenting, I tried a single hard disk in both positions -- one
> position let me see the disk directly (as though it was a direct,
> str8-thru connection), the other position showed up detected by
> the boot BIOS as a 7MB HD by some unrecognized vendor.   In
> linux, I'm able to access and use the hard disk when it appears
> 'str8-thru', but linux sees nothing concerning the 7MB pseudo HD.
>
> Is my expectation that the driver would simply recognize the
> external enclosure by whatever I had the external enclosure set to,
> too optimistic?  Do I need to run some special util to setup the disks in
> JBOD mode?  I guess I thought I only needed to worry about
> 'special utils' if I was using the disk-pair in a RAID config (0/1)...
>
> It seems there should be a linux util to manage the "container",
> 'sil57xx'  --  I take it is not used for RAID-only config?
>
> My ultimate aim is to use it in a RAID-0, mirror config (my luck
> with SATA disk drives has been abysmal, of late (*sigh*)).

I assume you mean raid-1.  I'm seeing a lot of people lose data even
with that.  There seem to be a lot of firmware specific bugs recently
(not just seagate). Be sure and mix vendors / batches / etc. in an
effort to keep away from near simultaneous double disk failure.

> Anyone with any real-world experience about when the 3Gb SAS
> starts to become a bottleneck?  I know that theoretically, it could
> support a hair over 350MB/s if there was no overhead, which would
> reliably only support 2 hard disks at full speed (assuming ~120MB/s
> max linear read speed/disk).

In my real world tests I've never seen a single drive achieve beyond
about 80MB/sec.  (5GB/min is the way I actually measure it.  That was
using SATA directly on the MB which I assume is as fast a PCIe.)

But very few people have a heavy linear read / write load (I do, but
my use case is unusual).

Most apps use random i/o.  That is where raid in general should shine.
 That includes a PMP setup I assume.

> Does that jive with people's real-world
> experience?  I.e. port-multipliers can provide full throughput for
> 2-HD's but not likely 3?
> Should I be looking for an sil57xx program somewhere (the box contained
> a mini-CD, but it looks like a driver for an older kernel (2.6.9).  Not so
> sure about it's usefulness in my setup.
>
> Thanks,
> -linda
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
