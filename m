From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 10:42:28 -0400
Message-ID: <45FAACD4.6000709@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca> <45FAAACE.6000503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1844 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965277AbXCPOma (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:42:30 -0400
In-Reply-To: <45FAAACE.6000503@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
> Hello.
> 
> Mark Lord wrote:
..
>>>    Again, ata_data_xfer() doesn't seem capable of performing ECC 
>>> read/writes
>>> -- the ECC bytes must be transferred in 8-bit mode, AFAIR. 
>>> ata_data_xfer()
>>> can oinly do that for optionally trailing odd byte.
> 
>> I have no idea what that was all about.  Care to explain again?
> 
>    Care to read the standards? :-/
> 
>> RWLONG transfer the ECC info 8-bits at a time, using 16-bit words
>> to do so, no different from normal.  ???
> 
>    From ATA-1:
> 
>    "The transfer of the vendor specific bytes shall be one byte at a 
> time over bits DD0-7 only (8-bits wide)."

> Yes, I said that already.  8-bits at a time, but using 16-bit transfers.
> Kinda like it says here, in ATA-3 section 7.16:

> The transfer of the vendor specifc bytes shall be 16 bit transfers
> with the vendor specific byte in bits 7 through 0.  Bits 15 through 8
> shall be ignored by the host.

But if we really want to be 100% compliant, we could consider dropping
to PIO0 for the command.  Not worth it, though, as in practice this is
not necessary, and it would mess up libata far more than is worthwhile
for this effort.

Cheers
