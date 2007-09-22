From: Mark Lord <liml@rtr.ca>
Subject: Re: ATAPI tape drives broken with libata
Date: Fri, 21 Sep 2007 20:28:31 -0400
Message-ID: <46F461AF.4020200@rtr.ca>
References: <46D5F97B.3050808@redhat.com>	<20070830005006.6951265a@the-village.bc.nu>	<46D6EC3B.8090306@redhat.com>	<20070831151903.37a60ba9@the-village.bc.nu>	<46E966C2.1050405@rtr.ca>	<46E97FE8.5090304@rtr.ca>	<46E9848E.2000704@rtr.ca> <20070919215035.1d4557ff@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4217 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbXIVA23 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Sep 2007 20:28:29 -0400
In-Reply-To: <20070919215035.1d4557ff@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, craig48@swbell.net

Alan Cox wrote:
>> I can read and write the tape successfully, and the written data matches
>> what is later read back from it.
>>
>> Here's the hack I used.  Not ready for mainline, but perhaps it will
>> help Alan or whomever come up with something nice for Jeff.
> 
> Its possible we should just scream and shout but for robustness and
> paranoia I just added ATA_HORKAGE_DRQ and skip the error setup in the
> case that HORKAGE_DRQ is set.
> 
> Just need the identify data now..

I duspect it's *all* ATAPI tape units.  Mine (Conner) is quite a bit older
than the other (Seagate) one that began this thread.  And ide-tape has no
problem with either drive.  Perhaps a whitelist rather than a blacklist here.

Meanwhile, my old Conner tape unit is several hundred miles away from me at present.

Cheers
