From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: pata_of_platform.c cannot build on sparc
Date: Thu, 22 Dec 2011 23:00:36 +0300
Message-ID: <4EF38C64.4030801@mvista.com>
References: <20111221.173810.971054965060472866.davem@davemloft.net> <4EF26ADB.2040504@gmail.com> <20111221.191459.1775781797635505733.davem@davemloft.net> <4EF28A8A.5070600@garzik.org> <4EF332ED.1050200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33584 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab1LVTBp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2011 14:01:45 -0500
Received: by wgbdr13 with SMTP id dr13so16367431wgb.1
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2011 11:01:44 -0800 (PST)
In-Reply-To: <4EF332ED.1050200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>, pawel.moll@arm.com, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, jgarzik@redhat.com

Hello.

On 12/22/2011 04:38 PM, Rob Herring wrote:

>>>>> It depends upon CONFIG_OF_IRQ which not all CONFIG_OF platforms
>>>>> support,
>>>>> in particular sparc does not support CONFIG_OF_PLATFORM because it
>>>>> precomputes all IRQs at boot time when it scans the device tree so all
>>>>> of the CONFIG_OF_IRQ infrastructure to probe and resolve IRQs at driver
>>>>> probe time is wrong and completely unnecessary.

>>>>> Add the proper dependencies so that pata_of_platform.c doesn't get
>>>>> built on sparc.

>>>>> CONFIG_OF_IRQ was severely misdesigned, it should just NOP out on
>>>>> platforms where the architecture has the final IRQ values already like
>>>>> sparc does.  But that's not how it was implemented at all, and now
>>>>> we're starting to have all of these drivers get hard dependencies on
>>>>> this mechanism and it's datastructures, and the resulting sparc build
>>>>> failures from time to time.

>>>>> Jeff, please push something like the following to Linus so that
>>>>> sparc's allmodconfig builds again.  Thanks.

>>>> Really, drivers should no longer use of_irq_to_resource (or
>>>> of_address_to_resource for that matter). The resources are setup by the
>>>> core OF code. The patch I sent does this.

>>> Thanks for taking care of this.

>> Being so late in 3.2-rc, it would be preferred to apply&push David's
>> patch for 3.2, and then get Rob's into libata-dev#upstream (linux-next).

>> That OK?

> Fine by me.

    But then it should be extended to undo David's patch, right? Or that patch 
just be reverted afterwards...

WBR, Sergei
