From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/05] sata_mv: msi masking fix (v2)
Date: Thu, 22 Jan 2009 14:22:21 +0900
Message-ID: <4978028D.3020501@gmail.com>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca> <4977C5A5.8070202@gmail.com> <49780167.1060208@rtr.ca> <497801F9.2070009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:48480 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZAVFWb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 00:22:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3967073rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 21 Jan 2009 21:22:30 -0800 (PST)
In-Reply-To: <497801F9.2070009@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Mark Lord wrote:
>> ..
>>>> +    /* Enable message-switched interrupts, if requested */
>>>> +    if (msi && 0 == pci_enable_msi(pdev))
>>>> +        hpriv->hp_flags |= MV_HP_FLAG_MSI;
>>>
>>> I just don't like CONSTANT OP EXPRESSION construct.
>> ..
>>
>> Heh.. Myself, I would normally just write it this way:
>>
>>     if (msi && !pci_enable_msi(pdev))
>>
>> But the "coding correctness police" might point out that
>> it reads funny (negatives and all that).
>>
>> But whatever way Jeff likes it, really.
> ..
> 
> .. perhaps keeping in mind that every little nit-picky revision
> like that requires me to go back to the deities at Marvell for
> re-approval before I can again present it for your blessings here.

Hey, we can con the system then by you submitting the original patch
and me following up with a nit picking patch right away, so if
changing the patch is too much of a hassle, please just go ahead with
the current patch.  :-)

Thanks.

-- 
tejun
