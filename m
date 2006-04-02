From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/15] libata: add dev->sata_spd_limit and helpers
Date: Sun, 02 Apr 2006 04:12:35 -0400
Message-ID: <442F8773.70306@pobox.com>
References: <11438230982257-git-send-email-htejun@gmail.com> <442ED9C5.3080301@pobox.com> <442F222F.3010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53993 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932078AbWDBIMn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:12:43 -0400
In-Reply-To: <442F222F.3010302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> NAK, I definitely don't want to closely associate phy and device 
>> parameters, because they are fundamentally two different things.
>>
>> We program and address PHYs, so perhaps a sata_phy struct is needed.
>>
>> Port multipliers also get interesting because we need to use ATA-ish 
>> commands to talk to the PM phys.  Perhaps a struct ata_port_mult 
>> inside ata_device is warranted, where one stores an array of sata_phy 
>> structs, and other PM-specific details.
>>
> 
> Hmmm... Yeah I also thought about extracting out PHY related information 
> out such that PATAs share them, SATA and PM have their own maybe marked 
> to indicate how they are connected. But that looked like going too far 
> especially because we don't have PM support yet. So, sticking it into 
> dev was sorta middle-ground.
> 
> How about putting it into ata_port around ap->cbl? This fits the current 
> model better and should work the same.

Sounds good to me.

	Jeff



