From: Linda Walsh <lkml@tlinx.org>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 09 Feb 2009 14:01:37 -0800
Message-ID: <4990A7C1.5060904@tlinx.org>
References: <498F42B6.8030607@tlinx.org> <da824cf30902090126p5e031e09q5b93da7a296bc849@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:37110 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbZBIWBq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 17:01:46 -0500
In-Reply-To: <da824cf30902090126p5e031e09q5b93da7a296bc849@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

Grant Grundler wrote:
> Linda,
> Please tell us which kernel version you have and include the dmesg
> output. Port multiplier support is generally working in 2.6.26 (and later
> releases) for several drivers.  PM support was added after 2.6.20.
---
    Sorry.  I'm a bit behind the edge at 2.6.27.3 --
but I tried a boot w/2.6.28.3 and didn't see a difference (had to return
to 27.3 as I accidently disabled a different driver and haven't regened it.

>
> Where did you find 350MB/s theoretical?
> Link is 8b10b encoded. So it's 10:1 of bits to bytes conversion of link rate.
> 3Gb/s --> 300MB/s in theory.
---
    Yep.  Forgot about that... was forgetting about the 2-bits of overhead,
so was using 3Gb/8/(1024*1024) -> 357.6, which I rounded down to 350... 
but forgot about the 10/8 encoding (just as I get rid of that conversion
habit from modem days, now I have to remember it as a special case for
SATA...:-)  ).

>
> For MB/s, it depends on the SATA controller. Don't expect more then
> 225-235 MB/s per port. At least one sata_sil3124 chip (3126?) is buggy
> and won't do more than 120MB/s read for all ports (170 MB/s write).
> See linux-ide archives for discussion on this.
---
    That's horrible!  I'd definitely call that a bug.  Right now,
the fastest I'm getting on my single ATA's is 70-80MB/s.  I could
get that per/ATA port.  So 120MB read for 4 SATA ports would be
a giant step backwards (170MB/s write?  write faster than read?)


