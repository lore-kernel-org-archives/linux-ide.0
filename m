From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: always use polling IDENTIFY
Date: Sun, 03 Dec 2006 08:02:40 -0500
Message-ID: <4572CAF0.2040806@pobox.com>
References: <20061203103032.GE11250@htj.dyndns.org> <20061203125603.493ebde6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:15053 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1758466AbWLCNCn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 08:02:43 -0500
In-Reply-To: <20061203125603.493ebde6@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Alan wrote:
> On Sun, 3 Dec 2006 19:30:32 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> libata switched to IRQ-driven IDENTIFY when IRQ-driven PIO was
>> introduced.  This has caused a lot of problems including device
>> misdetection and phantom device.
>>
>> ATA_FLAG_DETECT_POLLING was added recently to selectively use polling
>> IDENTIFY on problemetic drivers but many controllers and devices are
>> affected by this problem and trying to adding ATA_FLAG_DETECT_POLLING
>> for each such case is diffcult and not very rewarding.
>>
>> This patch makes libata always use polling IDENTIFY.  This is
>> consistent with libata's original behavior and drivers/ide's behavior.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> One possibility however would be to invert the flag we have now so we can
> try turning -on- IRQ polling on some devices in future and maybe figure
> it out that way around ?

Agreed, though it is low priority.

You'll note that Tejun's change only applies to the [large] set of 
drivers using libata-sff, rather than all drivers.  Modern, unbridged 
SATA controllers (ahci, sata_sil24) continue to do their own interrupts 
based on received packets (FIS's) through the use of the higher level 
libata hooks.

	Jeff



