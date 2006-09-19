From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 17/20] libata: make ata_pci_acquire_resources() handle
 iomap
Date: Tue, 19 Sep 2006 02:32:55 -0400
Message-ID: <450F8F17.5070104@pobox.com>
References: <11559779733267-git-send-email-htejun@gmail.com> <450F8471.4020004@pobox.com> <450F8DBB.4040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57249 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750847AbWISGdI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 02:33:08 -0400
In-Reply-To: <450F8DBB.4040101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>>> +    /* iomap PCI BARs */
>>> +    for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>> +        if (!(bar_mask & (1 << i)))
>>> +            continue;
>>
>> NAK, you only should map the stuff you are going to use.
>>
>> Mapped resources is finite, and you definitely don't want to map 
>> certain resources on certain controllers -- sometimes they are a 
>> memory area that's too large to be mapped, even.
> 
> Yeap, that's what @bar_mask and the above if () continue; block is for. 
>  Or am I misunderstanding you?

Oops, I missed that part.  Ignore my comment...


