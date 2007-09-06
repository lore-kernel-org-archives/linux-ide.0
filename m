From: Mark Lord <liml@rtr.ca>
Subject: Re: ICH Intel PATA short cable override...
Date: Wed, 05 Sep 2007 22:20:40 -0400
Message-ID: <46DF63F8.8070805@rtr.ca>
References: <6278d2220709040537n4c96ffcagd9c25c94ddd29ca1@mail.gmail.com> <20070906014209.142382c8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4484 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757394AbXIFCUl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Sep 2007 22:20:41 -0400
In-Reply-To: <20070906014209.142382c8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel J Blueman <daniel.blueman@gmail.com>, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Alan Cox wrote:
> On Tue, 4 Sep 2007 13:37:22 +0100
> "Daniel J Blueman" <daniel.blueman@gmail.com> wrote:
> 
>> We see that in ata_piix.c, there is a whitelist for (laptop) Intel ICH
>> controllers with short cables, tied to specific vendor subsystem IDs.
>> Since my mini-ITX Ibase MI910F has the subsystem IDs specified as
>> Intel [1], this is unusable.
>>
>> I can't find another existing mechanism to add short cable
>> information, to allow UDMA/66 for my on-board CF socket.
> 
> DMI is the other approach (if your box has sane responses to the
> dmidecode command we can do this). 

No, something more flexible is needed here.

For example, I have a Mini-ITX server here, which I personally have
equipped with a 3" 40W IDE cable that connects to a notebook drive.

The system currently uses UDMA just fine with the IDE drivers,
but I have not been able to convert it to use the (stock) libata drivers
because of this silly lack of end-user control.

We really need an override for this -- embedded folks would also apprecaate one.
Ditto for selecting transfer modes.

Cheers
