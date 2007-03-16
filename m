From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:58:26 +0300
Message-ID: <45FAB092.8020906@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca> <45FAAACE.6000503@ru.mvista.com> <45FAACD4.6000709@rtr.ca> <45FAAD11.9010905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33497 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965352AbXCPO6m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:58:42 -0400
In-Reply-To: <45FAAD11.9010905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Mark Lord wrote:

>>>>    Again, ata_data_xfer() doesn't seem capable of performing ECC 
>>>> read/writes
>>>> -- the ECC bytes must be transferred in 8-bit mode, AFAIR. 
>>>> ata_data_xfer()
>>>> can oinly do that for optionally trailing odd byte.

>>> I have no idea what that was all about.  Care to explain again?

>>    Care to read the standards? :-/

>>> RWLONG transfer the ECC info 8-bits at a time, using 16-bit words
>>> to do so, no different from normal.  ???

>>    From ATA-1:

>>    "The transfer of the vendor specific bytes shall be one byte at a 
>> time over bits DD0-7 only (8-bits wide)."

> Yes, I said that already.  8-bits at a time, but using 16-bit transfers.
> Kinda like it says here, in ATA-3 section 7.16:

    Heh, I give up. There was no word of 16-bit transfers before ATA-3. And 
waht I saw was the code doing this by 8-bit I/O (evem with added delays).
    Well, those ATA specs have always been quite messy: for example, polling 
protocol had an unnoticed race for years (device was allowed to clear BSY 
before asserting INTRQ, so there was no guarantee that the host's reading of 
the status reg. will actually clear drive's interrupt)...

>> The transfer of the vendor specifc bytes shall be 16 bit transfers
>> with the vendor specific byte in bits 7 through 0.  Bits 15 through 8
>> shall be ignored by the host.

> But if we really want to be 100% compliant, we could consider dropping
> to PIO0 for the command.

    Yeah, reading ATA-2 we see:

NOTE 31 - Some ATA-1 devices are not capable of delivering the 8 bit ECC 
immediately after the word sector data. BIOS and driver developers should use 
PIO mode 0 for 8 bit ECC accesses.

    That explains the delays I saw...

> Not worth it, though, as in practice this is
> not necessary, and it would mess up libata far more than is worthwhile
> for this effort.

    Agreed.

> Cheers

MBR, Sergei
