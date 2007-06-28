From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Thu, 28 Jun 2007 17:17:50 -0400
Message-ID: <4684257E.5070402@garzik.org>
References: <200706060104.18055.uwe.koziolek@gmx.net> <20070605231912.GW31565@havoc.gtf.org> <468421F9.8070809@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52245 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbXF1VRy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 17:17:54 -0400
In-Reply-To: <468421F9.8070809@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> Nevermind, I did it myself:
>> This ensures that we can easily make changes specific to the PATA port
>> on the newer SATA chips, and also does what I've been requesting -- use
>> the standard ata_bmdma_error_handler(), rather than creating custom code
>> that achieves the same effect.
>>
>>
>> diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
>> index ec3ae93..0752104 100644
>> --- a/drivers/ata/pata_sis.c
>> +++ b/drivers/ata/pata_sis.c
>>   
> Jeff,
> Did you have added  the patch you have  mailed on 06.06. anywhere or is
> this patch an email only patch. And how to continue?

It's in my mbox queue, should be in my next "run"... :)

	Jeff



