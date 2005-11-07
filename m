From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: sata_sil24 corruption details
Date: Mon, 7 Nov 2005 11:15:51 -0500
Message-ID: <87f94c370511070815t2e28fb67g16c8568f278e97ca@mail.gmail.com>
References: <20051107095956.27387.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:52508 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964856AbVKGQPv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Nov 2005 11:15:51 -0500
Received: by xproxy.gmail.com with SMTP id i30so423461wxd
        for <linux-ide@vger.kernel.org>; Mon, 07 Nov 2005 08:15:51 -0800 (PST)
In-Reply-To: <20051107095956.27387.qmail@science.horizon.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

On 7 Nov 2005 04:59:56 -0500, linux@horizon.com <linux@horizon.com> wrote:
> I just compared the two halves of my RAID-1 mirrors and found something
> very interesting...
>
> sector 95958 of the two halves looks like:
>
>  0000000: 9db4 87cf 4e2f cba7 c727 1feb 5f08 b7cf  ....N/...'.._...
<snip>
>  0000150: 5d70 fc7b aa06 146c cea1 fbac ff33 d73f  ]p.{...l.....3.?
>  0000160: 40cc f31f 30f1 5957 bffe 3b93 fbc1 ac68  @...0.YW..;....h
>  0000170: 90fe 94bf 6770 ded7 17bf c77e 4be8 15af  ....gp.....~K...
> -0000180: 4a2b 371e 8a1c baf5 7ab0 7998 84cb bfae  J+7.....z.y.....
> +0000180: 6dd2 09ec b42b 0638 996e e914 7a7c d353  m....+.8.n..z|.S
>  0000190: 0f5e e234 e488 997d 5564 a630 e7ad c3db  .^.4...}Ud.0....
...
>
> Then sector 129547:
>  0000000: 494e 41e8 0101 0002 0000 0065 0000 0069  INA........e...i
<snip>
>  00000f0: 9000 0040 ffff ffff 1801 0000 0000 0000  ...@............
>  0000100: 494e 81a4 0102 0001 0000 0000 0000 0000  IN..............
> -0000110: 0000 0001 0000 0000 0000 0000 0000 055a  ...............Z
> -0000120: 435f 2276 096e bf0e 4345 8a5f 34e9 60ae  C_"v.n..CE._4.`.
> +0000110: 0000 0001 0000 0000 0000 0000 0000 0557  ...............W
> +0000120: 435e e888 066b 4474 4345 8a5f 34e9 60ae  C^...kDtCE._4.`.
>  0000130: 4345 8a5f 34e9 60ae 0000 0000 0000 01f2  CE._4.`.........
<snip>
>
> And sector 195094:
>  0000000: 494e 41e8 0102 0019 0000 0065 0000 0069  INA........e...i
<snip>
>  0000100: 494e 41e8 0101 0002 0000 0065 0000 0069  INA........e...i
> -0000110: 0000 0002 0000 0000 0000 0000 0000 0010  ................
> -0000120: 435f 1c9a 0be9 b322 4355 9502 1f35 8dad  C_....."CU...5..
> +0000110: 0000 0002 0000 0000 0000 0000 0000 000e  ................
> +0000120: 435d 942d 069a 8c21 4355 9502 1f35 8dad  C].-...!CU...5..
>  0000130: 4355 9502 1f35 8dad 0000 0000 0000 0062  CU...5.........b
<snip>
>
> These shorts bursts of inconsistencies are alarming.  The number of error bits
> doesn't look like RAM errors, and in any case, the machine has ECC
> memory, not overclocked, and was burned in with memtest86+ and prime95
> for multiple days to make sure RAM was reliable.
>
> FWIW, those sectors numbers are relative to the partition, which itself starts on
> raw disk sector 3903795, so the device-level partition numbers are
> partition-relative.  The partition
> 3903795 + 95958 = 3999753 = 0x3D0809
> 3903795 + 129547 = 4033342 = 0x3D8B3E
> 3903795 + 195094 = 4098889 = 0x3E8B49
>
> Hardware is single-core AMD64 processor, nForce chipset, generic motherboard,
> 2x1 GB ECC SDRAM, 3x Sil3132 SATA controllers, 6x 400 GB 7200.8 drives.
>
>
> I finished "badblocks -b 4096 -c 65536 -s -v -w -t random" run on 350 G of one drive
> without seeing problems, and am working on the other 5.
> (In parallel, just to stress the driver.)
>
> Does anyone have any recommended diagnostics for seeing whether a drive reliably
> remembers data you give to it?  Ones that particularly abuse the disk driver?
>
> Thanks!
> -
Interesting.  I'm particularily surprised the data corruption is so
localized.  I had assumed it would be an entire sector.  Maybe that
will give someone an idea of what is causing the corruption.

FYI: We last tested a Sil 3112 for corruption issues with a SuSE
2.6.11 kernel.  We found that in copying 2 GB files from a SIG PCI
connected PATA drive to a 3112 connected SATA drive we would get
occasional corruption.  Generally we found between 1 and 3 of each
hundred files would get corrupted.  We detected corruption by running
an MD5 on the PATA and SATA copies of the files.

Based on seeing other postings of data corruption, I just assumed it
was a driver issue.  On the same machine we have run numerous PATA to
PATA copies like above with no consistentcy issues.  Both PATA drives
would have been set to master and connected to the SIG PCI card.

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
