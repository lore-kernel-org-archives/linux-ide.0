From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Mon, 06 Aug 2007 21:18:06 +0400
Message-ID: <46B757CE.2070700@ru.mvista.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com> <1186420206.23890.7.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10849 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757902AbXHFRQE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 13:16:04 -0400
In-Reply-To: <1186420206.23890.7.camel@orchid.arb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Bob Ham wrote:

>>HPT374 BIOS seems to only save f_CNT register value for the function #0 before
>>re-tuning DPLL causing the driver to report obviously distorted f_CNT for the
>>function #1 -- fix this by always reading the saved f_CNT register value from
>>in the init_chipset() method the function #0 of HPT374 chip.
>>While at it, introduce 'chip_type' for the copy of the 'struct hpt_info' member
>>and replace the structure assignment by memcpy()...

> HPT374: IDE controller at PCI slot 0000:00:0d.0
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
> HPT374: chipset revision 7
> HPT374: DPLL base: 48 MHz, f_CNT: 142, assuming 33 MHz PCI
> HPT374: using 50 MHz DPLL clock
> HPT374: 100% native mode on irq 16
>     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
> ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 16 (level, low) -> IRQ 16
> HPT374: DPLL base: 48 MHz, f_CNT: 142, assuming 33 MHz PCI
> HPT374: using 50 MHz DPLL clock
>     ide4: BM-DMA at 0xed00-0xed07, BIOS settings: hdi:DMA, hdj:pio
>     ide5: BM-DMA at 0xed08-0xed0f, BIOS settings: hdk:DMA, hdl:pio

> again, followed by a hard lock

    Hm, well, this is indeed tough case but at least it prodded me to fix some 
issues.  Maybe it's worth for you to file a bug at bugzilla.kernel.org...

MBR, Sergei
