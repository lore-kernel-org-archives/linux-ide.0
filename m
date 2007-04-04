From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Wed, 04 Apr 2007 02:20:41 -0400
Message-ID: <461343B9.6090304@garzik.org>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41738 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992694AbXDDGUq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 02:20:46 -0400
In-Reply-To: <45FAA822.7050208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Sergei Shtylyov wrote:
>>> The fussy bit is that these commands require a non-standard
>>> sector size, usually 520 bytes instead of 512.
>>
>>    Which requires from the drivers to be able to turn off IDE prefetch 
>> (and maybe posting too).  I don't see that in this patch (or are you 
>> expecting them to just "snoop' the commands and do it automagically?).
> 
> Most controllers seem to be behave well enough
> and just not muck up.  And if it fails on any "too clever" controllers,
> then no big deal -- we just switch to a controller that works instead.
> 
> This is not an essential command for normal operation.
> What it is for, is injecting errors so that we can experience
> firsthand the (excellent or crappy) error handling in the kernel
> and in applications.  And then work out and test better strategies.
> 
> So 100% working everywhere, for an obsolete opcode, isn't really
> essential to me.  But it should work most places, and it does.
> 
>>    Again, ata_data_xfer() doesn't seem capable of performing ECC 
>> read/writes
>> -- the ECC bytes must be transferred in 8-bit mode, AFAIR. 
>> ata_data_xfer()
>> can oinly do that for optionally trailing odd byte.
> 
> I have no idea what that was all about.  Care to explain again?
> RWLONG transfer the ECC info 8-bits at a time, using 16-bit words
> to do so, no different from normal.  ???
> 
> Here it is again with the whitespace not so messed up.
> 
> Thanks.
> 
> The READ/WRITE LONG commands are theoretically obsolete,
> but the majority of drives in existance still implement them.
> 
> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
> interest for fault injection testing -- eg. creating "media errors"
> at specific locations on a disk.
> 
> The fussy bit is that these commands require a non-standard
> sector size, usually 520 bytes instead of 512.
> 
> This patch adds support to libata for READ/WRITE LONG commands
> issued via SG_IO/ATA_16.
> 
> This patch was generated against a 2.6.21-rc3-git7 base:
> 
> drivers/ata/libata-core.c |   20 ++++++++++----------
> drivers/ata/libata-scsi.c |   12 ++++++++++++
> include/linux/ata.h       |    6 ++++++
> include/linux/libata.h    |    2 ++
> 4 files changed, 30 insertions(+), 10 deletions(-)
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

applied


