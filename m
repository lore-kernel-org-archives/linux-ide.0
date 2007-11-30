From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Fri, 30 Nov 2007 09:12:03 -0500
Message-ID: <47501A33.3030405@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com>	<20071129160555.38ee2edc@the-village.bc.nu>	<474EE561.7010207@gmail.com>	<474EE5F8.1030409@gmail.com>	<474F0B11.7000205@rtr.ca>	<474F4294.9030203@gmail.com>	<474F6163.3030500@rtr.ca>	<474F68B9.2090203@gmail.com> <20071130134053.0085a2b4@the-village.bc.nu> <47501751.5020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50935 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383AbXK3OMJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2007 09:12:09 -0500
In-Reply-To: <47501751.5020601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Alan Cox wrote:
>>> polling for media change which involves reading maybe a few tens of
>>> bytes.  The overhead of doing those using PIO wouldn't be too much more
>>> than the cost of writing CDBs out.  It would help more if we can cut
>>> down the number of commands used for testing media changed event (on my
>>> to do list).
>> Actually the overhead is foul on some laptops as the command byte write
>> wakes up the controller, which then whirrs away for a bit recovering its
>> status before deciding to give us an answer.
> 
> Yeah, but that happens whether DMA is used or not.  Probably what's
> needed is disabling media presence polling according to power profile.
> 
>>> Does module parameter / sysfs node sound good enough to you?
>> You mean like the existing "dma" one we already have which lets you turn
>> on/off atapi DMA and could be extended with another bit so we went from
>>
>> 1 - disk
>> 2 - cd
>> 4 - cf
>>
>> to
>>
>> 1 - disk
>> 2 - cd (basic commands)
>> 4 - cf
>> 8 - cd (all)
>>
>>
>> (The idea being that its ordered so troubleshooting almost always comes
>> down to 1,3 - or 1,3,7  with this). So we have 99.9% of this
> 
> Basically, yes but I think it would be nice to be able to change the
> value on the fly.

It would also be nice to change it per-device rather than globally...

	Jeff



