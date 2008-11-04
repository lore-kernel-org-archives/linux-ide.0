From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Tue, 04 Nov 2008 19:40:43 +0900
Message-ID: <491026AB.1090704@kernel.org>
References: <871vxrzssj.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59467 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbYKDKlI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 05:41:08 -0500
In-Reply-To: <871vxrzssj.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Evgeni Golov <sargentd@die-welt.net>

Elias Oltmanns wrote:
> apparently, we have the first case of a quirky implementation of
> idleimmediate with unload feature in a device, or I'm barking up the
> wrong tree, of course. Evgeni Golov has reported the following on
> hdaps-devel:

Aieeeee...

> Evgeni Golov <sargentd@die-welt.net> wrote:
>> Hi,
>>
>> I have a ThinkPad Z61m with a 100GB S-ATA TOSHIBA MK1032GSX.
> [...]
>> Now I thought I should try the new interface and compiled 2.6.28-rc2,
> [...]
>> After that I could park the heads and got the following in dmesg:
>>
>> ata1: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xf
>> ata1: SError: { PHYRdyChg CommWake }
>> ata1: hard resetting link
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
>> ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
>> ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
>> ata1.00: ACPI cmd ef/02:00:00:00:00:a0 succeeded
>> ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
>> ata1.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
>> ata1.00: configured for UDMA/100
>> ata1.00: configured for UDMA/100
>> ata1: EH complete
>> sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors: (100 GB/93.1 GiB)
>> sd 0:0:0:0: [sda] Write Protect is off
>> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>> sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors: (100 GB/93.1 GiB)
>> sd 0:0:0:0: [sda] Write Protect is off
>> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
> 
> The only explanation I could come up with so far is that the head park
> command, for some reason or other, causes the device to set
> SERR_PHYRDY_CHG and SERR_COMM_WAKE in serror, thus triggering the
> handling of hotplug events. Do you have any idea what's really going on
> here and what can / should be done about it?

Is it a laptop?  Does 'hdparm -y' cause the same thing?  Can you post
"hdparm -I"?

Thanks.

-- 
tejun
