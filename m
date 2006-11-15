From: Andrew Morton <akpm@osdl.org>
Subject: Re: Testing with 2.6.19-rc5
Date: Wed, 15 Nov 2006 11:03:33 -0800
Message-ID: <20061115110333.4daccb6d.akpm@osdl.org>
References: <f4527be0611150645h7cc2791cub7a2ca753156564f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:56759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030890AbWKOTDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2006 14:03:41 -0500
In-Reply-To: <f4527be0611150645h7cc2791cub7a2ca753156564f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 15 Nov 2006 14:45:27 +0000
"Andrew Lyon" <andrew.lyon@gmail.com> wrote:

> Andrew,
> 
> You asked me to test if the issues I reported (Re: JMicron 20360/20363
> AHCI Controller much slower with 2.6.18 / Re: SATA CD/DVDRW Support in
> 2.6.18? / Re: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron
> 20360/20363 2.6.18.1) were still present with 2.6.19-rc5, I tried it
> today and ran into a very strange problem, the 4 400gb Samsung SATA
> HDs connected to ata_piix were detected as normal but the raid that
> they belong to failed to start, the raid system couldnt find any
> superblock at all.

You mean that the raid works in 2.6.18 but not in 2.6.19-rc5?   Ouch.

What sort of raid setup are you using?

> Is it possible that the addressing of the sectors has changed such
> that the device data structure does not map to the on disk data in the
> same way as it did with 2.6.18.x ?

Sounds unlikely.  More likely we're reading junk from the disks.

> unfortunately they drives are not
> partitioned, just added straight to the raid, otherwise checking the
> partition table would be a good test.
> 
> I had a idea about taking a copy of a few kbs of data from each drive
> using both kernel versions and comparing them,

Good idea.

> but if the raid is
> started under 2.6.18 its possible the data would change anyway.. so I
> dont think that would work.

Do you actually need to start the raid under 2.6.18?  Shut the raid down,
take a copy of the first 32k of each disk, then boto 2.6.19-rc5 and do the
same?

> Any suggestions? I really want to complete testing of the two issues I
> reported..

Thanks.
