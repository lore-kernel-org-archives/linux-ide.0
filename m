From: Rob Herring <robherring2@gmail.com>
Subject: Re: pata_of_platform.c cannot build on sparc
Date: Thu, 22 Dec 2011 07:38:53 -0600
Message-ID: <4EF332ED.1050200@gmail.com>
References: <20111221.173810.971054965060472866.davem@davemloft.net> <4EF26ADB.2040504@gmail.com> <20111221.191459.1775781797635505733.davem@davemloft.net> <4EF28A8A.5070600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50859 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1LVNi5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2011 08:38:57 -0500
Received: by ghbz12 with SMTP id z12so5425476ghb.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2011 05:38:56 -0800 (PST)
In-Reply-To: <4EF28A8A.5070600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, pawel.moll@arm.com, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, jgarzik@redhat.com

On 12/21/2011 07:40 PM, Jeff Garzik wrote:
> On 12/21/2011 07:14 PM, David Miller wrote:
>> From: Rob Herring<robherring2@gmail.com>
>> Date: Wed, 21 Dec 2011 17:25:15 -0600
>>
>>> On 12/21/2011 04:38 PM, David Miller wrote:
>>>>
>>>> It depends upon CONFIG_OF_IRQ which not all CONFIG_OF platforms
>>>> support,
>>>> in particular sparc does not support CONFIG_OF_PLATFORM because it
>>>> precomputes all IRQs at boot time when it scans the device tree so all
>>>> of the CONFIG_OF_IRQ infrastructure to probe and resolve IRQs at driver
>>>> probe time is wrong and completely unnecessary.
>>>>
>>>> Add the proper dependencies so that pata_of_platform.c doesn't get
>>>> built on sparc.
>>>>
>>>> CONFIG_OF_IRQ was severely misdesigned, it should just NOP out on
>>>> platforms where the architecture has the final IRQ values already like
>>>> sparc does.  But that's not how it was implemented at all, and now
>>>> we're starting to have all of these drivers get hard dependencies on
>>>> this mechanism and it's datastructures, and the resulting sparc build
>>>> failures from time to time.
>>>>
>>>> Jeff, please push something like the following to Linus so that
>>>> sparc's allmodconfig builds again.  Thanks.
>>>>
>>>
>>> Really, drivers should no longer use of_irq_to_resource (or
>>> of_address_to_resource for that matter). The resources are setup by the
>>> core OF code. The patch I sent does this.
>>
>> Thanks for taking care of this.
> 
> Being so late in 3.2-rc, it would be preferred to apply&push David's
> patch for 3.2, and then get Rob's into libata-dev#upstream (linux-next).
> 
> That OK?
> 

Fine by me.

Rob
