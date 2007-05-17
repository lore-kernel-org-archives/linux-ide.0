From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Thu, 17 May 2007 17:50:12 +0200
Message-ID: <464C79B4.1060808@gmail.com>
References: <464AACDF.1030903@tw.ibm.com>	<464AB2F3.7030103@tw.ibm.com> <20070516140201.29d0f6f0@the-village.bc.nu> <464C1972.6050205@tw.ibm.com> <464C1FA7.20503@gmail.com> <464C77EC.10607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:24990 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbXEQPur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 11:50:47 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1002300nza
        for <linux-ide@vger.kernel.org>; Thu, 17 May 2007 08:50:47 -0700 (PDT)
In-Reply-To: <464C77EC.10607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> I don't really know how to fix this.  It seems the only options are 1.
>> disable_irq() as IDE does which sucks if the IRQ is shared 2. doing PIO
>> transfers with local IRQ disabled and spinlock locked which makes the
>> system stutter like hell.  Oh crap, all this because we don't have
>> simple reliable IRQ pending bit.  :-(
>>
>> Oh, BTW, we do have reliable IRQ pending bit on ata_piix's.  The IRQ bit
>> in BMDMA status acts as a IRQ pending even if the command isn't a DMA
>> one.  This is why we clear BMDMA IRQ even after nodata or PIO commands,
>> so we can probably solve the problem nicely for ata_piix by calling
>> ata_port_freeze() if IRQ is received while ATA_PFLAG_HSM_WQ is set.
>> sata_sil also has reliable IRQ pending bit.
> 
> I'm not sure if this suggestion is the same as what you just described,
> but what we can do here is just set a flag before the PIO block,
> and clear it again after PIO completes.
> 
> The libata IRQ handler for that channel would then check for this flag
> on entry, before touching any chipset registers, and if it sees the flag
> then it should self-disable the IRQ and return immediately.
> 
> The PIO block would then also have to know to re-enable the IRQ on
> completion.
> 
> This way, we only disable the IRQ when it is actually necessary
> for the specific hardware at run-time.

Heh heh, that was the first approach tried and we couldn't solve
unexpected IRQ problem which can be triggered by cable problem or
whatever.  If the work thread doesn't turn off IRQ and the IRQ handler
doesn't clear it when it happens, we end up with nobody-cared.

-- 
tejun
