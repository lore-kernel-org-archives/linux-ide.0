From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 15:12:10 -0500
Message-ID: <497E191A.1040902@pobox.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0F76.6020606@ru.mvista.com>	<20090126193550.27eef301@lxorguk.ukuu.org.uk>	<497E12BC.1080809@ru.mvista.com> <20090126195430.3a8aa1ce@lxorguk.ukuu.org.uk> <497E1700.8090206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60929 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbZAZUMZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:12:25 -0500
In-Reply-To: <497E1700.8090206@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Sergei Shtylyov wrote:
> Alan Cox wrote:
> 
>>>>>> +    if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
>>>>>> +        return 0;
>>>>>> +    return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;
> 
>>>>>   Refer to afa_dev_cf_sata() on how it's done in really optimal way.
> 
>>>> To what ? - there is no ata or afa_dev_cf_sata ?
> 
>>>    Very funny. Meant to be ata_dev_is_sata(), of course.
> 
>> We don't have one of those either - do you mean ata_id_is_sata ? If so
>> then yes that looks like it might be slightly cleaner although its
>> probably one instruction difference from the .s files.
> 
>    That extra *if* cost more than instruction I think.

Either way, this is irrelevant, since this isn't used in any hot path 
that I am aware of... :)

Alan just posted a reasonable explanation in the "The logic is this" 
email, maybe we can reboot the discussion from there?

Responding to a side point, I don't think its a big deal to combine 
fixes and improvements into a single patch, if you are dealing with the 
same few lines of code.  Just make sure the patch description (and/or 
code comment) enumerates the fixes and improvements both...

	Jeff



