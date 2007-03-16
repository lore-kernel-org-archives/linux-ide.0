From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:33:50 +0300
Message-ID: <45FAAACE.6000503@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33363 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965330AbXCPOeC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:34:02 -0400
In-Reply-To: <45FAA822.7050208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Mark Lord wrote:

>>> The fussy bit is that these commands require a non-standard
>>> sector size, usually 520 bytes instead of 512.

>>    Which requires from the drivers to be able to turn off IDE prefetch 
>> (and maybe posting too).  I don't see that in this patch (or are you 
>> expecting them to just "snoop' the commands and do it automagically?).

> Most controllers seem to be behave well enough
> and just not muck up.  And if it fails on any "too clever" controllers,
> then no big deal -- we just switch to a controller that works instead.

   IDE controllers are generally not known as "clever" -- and that's what's 
frightening me... :-)

> This is not an essential command for normal operation.
> What it is for, is injecting errors so that we can experience
> firsthand the (excellent or crappy) error handling in the kernel
> and in applications.  And then work out and test better strategies.

> So 100% working everywhere, for an obsolete opcode, isn't really
> essential to me.  But it should work most places, and it does.

    I don't think it should *correctly* work anywhere w/prefetch on, IDE bus 
wise.  Maybe that just doesn't show up on host side (but well might have been).

>>    Again, ata_data_xfer() doesn't seem capable of performing ECC 
>> read/writes
>> -- the ECC bytes must be transferred in 8-bit mode, AFAIR. 
>> ata_data_xfer()
>> can oinly do that for optionally trailing odd byte.

> I have no idea what that was all about.  Care to explain again?

    Care to read the standards? :-/

> RWLONG transfer the ECC info 8-bits at a time, using 16-bit words
> to do so, no different from normal.  ???

    From ATA-1:

    "The transfer of the vendor specific bytes shall be one byte at a time 
over bits DD0-7 only (8-bits wide)."

> Here it is again with the whitespace not so messed up.

   I'm sorry, it seems only being messed on my side, due to format=flowed. :-/

> The READ/WRITE LONG commands are theoretically obsolete,
> but the majority of drives in existance still implement them.

> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
> interest for fault injection testing -- eg. creating "media errors"
> at specific locations on a disk.

> The fussy bit is that these commands require a non-standard
> sector size, usually 520 bytes instead of 512.

    It's 516 bytes, not 512 as you claim. Well, maybe the extra odd bytes 
don't matter anyway in this GIGO case... :-)

> This patch adds support to libata for READ/WRITE LONG commands
> issued via SG_IO/ATA_16.

> This patch was generated against a 2.6.21-rc3-git7 base:

MBR, Sergei
