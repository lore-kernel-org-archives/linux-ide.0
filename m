From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 29 Sep 2004 23:28:19 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415B7D53.9020101@pobox.com>
References: <8746466a04092114163b3c0618@mail.gmail.com> <415B34FC.8060908@pobox.com> <8746466a0409291532471417b8@mail.gmail.com> <20040930023428.GA200873@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268658AbUI3D2f
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 23:28:35 -0400
In-Reply-To: <20040930023428.GA200873@sgi.com>
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Dave <dave.jiang@gmail.com>, jeremy.higdon@sgi.com, linux-ide@vger.kernel.org

Jeremy Higdon wrote:
> On Wed, Sep 29, 2004 at 03:32:34PM -0700, Dave wrote:
> 
>>On Wed, 29 Sep 2004 18:19:40 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>>So where did the discussion on this patch land?
> 
> 
> The only part that made sense to me was the LED patch, which should
> just be a single line of code.

So maybe you or Dave could be convinced to roll that into a separate 
patch, since we have consensus on that item?



>>I believe waiting for you to comment on whether to put in a hook for
>>controllers that do not support ATA_NIEN so it can mask/unmask IRQ
>>with a fixup.  Even though the spec for this particular SATA
>>controller says the bit is reserved, it seems to work just fine. From
>>my understanding, the registers are actually on the drives, and the
>>ones we write to the HBAs are just shadow registers right? I suppose
>>either we can use the "undocumented" reserved bit for ATA_NIEN, or
>>provide some sort of special hook in lib_ata core to clear the
>>interrupt bit....
> 
> 
> I don't think we need this.  In vsc_sata_tf_load(), we see if the
> ATA_NIEN bit has changed and call vsc_intr_mask_update() as
> necessary.
> 
> 
>>Obviosly if it is working on IA32 or IA64, this code must be only
>>scanning device 0 per port and not device 1. Not sure why it is only
>>scanning 1 device on IA platforms, but both on XScale. Either way we
>>have a corner case here that should be addressed....
> 
> 
> Jeff, I don't remember how libata knows how many devices a port
> can have.  Which field is it?

By default it only scans device 0, since SATA is a point-to-point 
connection where there is no possibility for more than one device :)

However, some hardware chooses to emulate master/slave mode.  Use of 
this, particularly on Vitesse/Intel, is highly discouraged in favor of 
DPA mode.  I would prefer to not support master/slave mode at all.

Technically speaking, one sets the ATA_FLAG_SLAVE_POSS flag to tell the 
libata core to scan for device 1.

If we are talking about Port Multipliers, those aren't supported at all yet.

	Jeff


