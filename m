From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata queue updated
Date: Mon, 30 Jan 2006 10:01:27 -0500
Message-ID: <43DE2A47.2030607@pobox.com>
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de> <43DDBA71.6040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37085 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932301AbWA3PBn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 10:01:43 -0500
In-Reply-To: <43DDBA71.6040402@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Ingo Oeser wrote:
> 
>> Hi Jeff,
>>
>>
>> On Saturday 28 January 2006 19:25, Jeff Garzik wrote:
>>
>>> Testing and merge point in Tejun's flood of patches :)  The patch
>>> below is against current linux-2.6.git.
>>
>>
>> These "function(unsigned int *classes)" style functions in 
>> "libata-core.c" worry me somewhat.  Esp. that sometimes you have one 
>> class,
>> sometimes two.
>> This looks like a bug waiting to happen for me.
>>
>> Could we somehow get a
>> struct ata_classes {
>>     unsigned int master;
>>     unsigned int slave;
>> }
>>
>> here (or similiar), before this is in used everywhere?
>>
>> Usage would be function(struct ata_classes *classes) then.
>>
> 
> Hello,
> 
> I object.  Using array is intentional.  Slave aware controllers (PATA / 
> ata_piix) will use [0..1], most SATA controllers will use only [0], and 
> PM aware ones will use [0..15].  The intention was requiring low level 
> drivers of only what they know and normalize them in the core layer.

Yep, that's fine.

We don't need to be writing code for the case where somebody doesn't 
know the C language.

	Jeff



