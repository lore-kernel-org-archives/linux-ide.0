From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] libata: improve ata_bus_probe failure handling, take
 2
Date: Mon, 03 Apr 2006 06:38:47 -0400
Message-ID: <4430FB37.6040600@pobox.com>
References: <11439680863256-git-send-email-htejun@gmail.com> <442FE142.7030304@pobox.com> <4430ECEF.30307@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:22950 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750901AbWDCKiy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 06:38:54 -0400
In-Reply-To: <4430ECEF.30307@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Albert Lee wrote:
> Jeff Garzik wrote:
>> Applied both series to #upstream.
>>
>> Albert, please check the irq-pio branch and make sure my merge is correct.
>>
> 
> The irq-pio branch looks good.
> 
> I've a minor fix for cleanup, etc.
> Will submit it later.


Thanks.

For the record, I do consider irq-pio upstream ready.  It still needs to 
wait for Tejun's EH work to make it upstream, to give upstream people 
the test sets of

	- prep EH (2.6.17-rc1)
	- EH
	- NCQ
	- irq-pio

Since each of these sets is staged, upstream testers will be able to say 
"2.6.17-rc1 works, but 2.6.18-git1 doesn't", which gives us a lot of 
good info.

	Jeff


