From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: HPA support
Date: Fri, 13 Apr 2007 12:46:37 -0400
Message-ID: <461FB3ED.50708@pobox.com>
References: <20070411002313.29069ca5@the-village.bc.nu> <20070413153343.GA26304@athena.road.mcmartin.ca> <20070413154432.GC26304@athena.road.mcmartin.ca> <461FAEC2.6000705@pobox.com> <20070413163341.GA27674@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37470 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbXDMQql (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Apr 2007 12:46:41 -0400
In-Reply-To: <20070413163341.GA27674@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@canonical.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Kyle McMartin wrote:
> On Fri, Apr 13, 2007 at 12:24:34PM -0400, Jeff Garzik wrote:
>> Kyle McMartin wrote:
>>> Oddly, the command at least executes and doesn't MCE (but it's not at all
>>> happy either) if I use ATA_PROT_PIO. I wonder if ATA_PROT_NODATA is 
>>> buggered
>>> on this sata_nv chip (Asus A8N-E).
>>>
>>> Weird...
>>
>> Try turning off ADMA using the module parameter, and see if 
>> ATA_PROT_NODATA magically works.
>>
>> ADMA is an advanced command execution mode, and it may not be 
>> appropriate for certain non-data commands.
>>
> 
> Thanks so much, Jeff! This did it. Think we should drop ADMA by default?
> Do you know off-hand if there's any other drivers this might bite us on?

There is a myriad of choices.  A lot of controllers snoop the ATA 
command set, and perform some special internal behavior (like 
autodetecting taskfile protocol, for example).  Similar to how several 
Promise controllers only use DMA for specific SCSI READ/WRITE commands, 
and PIO for everything else, the most optimal choice is generally to use 
the DMA engine for fast path DMA data commands, and other commands.

You don't want to punish the fast path by turning off ADMA, merely due 
to an issue relating to a non-fast-path command.

	Jeff



