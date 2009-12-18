From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH RFC] ahci: implement handoff quirk
Date: Thu, 17 Dec 2009 21:54:30 -0600
Message-ID: <4B2AFCF6.5030602@gmail.com>
References: <485882FE.1060409@kernel.org> <4B29D0FA.6060805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61618 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853AbZLRDyd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 22:54:33 -0500
Received: by yxe17 with SMTP id 17so2580132yxe.33
        for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 19:54:32 -0800 (PST)
In-Reply-To: <4B29D0FA.6060805@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com

On 12/17/2009 12:34 AM, Jeff Garzik wrote:
> On 06/17/2008 11:37 PM, Tejun Heo wrote:
>> ahci 1.2 has an exciting! new feature called BIOS/OS handoff which
>> basically is there to allow BIOS to keep tinkering with the controller
>> even after OS starts executing. I have no idea what this is useful
>> for but it's there and we need to do it.
>>
>> This patch implements the handoff as FIXUP_HEADER as the controller
>> needs to be claimed before the OS changes any configuration including
>> IRQ routing.
>>
>> I'm yet to see any controller which actually requires this, so it's
>> not for inclusion yet. Maybe keep this in a separate branch?
>>
>> RFC, DON'T COMMIT
>> ---
>> drivers/pci/quirks.c | 109
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 109 insertions(+)
>
> Looking through old emails... did AMD ever confirm the usefulness of
> this patch? Is it actually needed in the field? I'm guessing the silence
> implies "No"... :)

Well, we only implemented the feature bit displaying for the BOH 
"capability" recently, so I guess we wouldn't likely have seen it if 
something did advertise it. However, it's true I don't know why any sane 
BIOS would want to do this. Can't hurt to have the support, however..
