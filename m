From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
Date: Mon, 9 Nov 2015 20:33:29 +0300
Message-ID: <5640D8E9.7080808@cogentembedded.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
 <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org>
 <20151109144932.GE22591@linux-mips.org>
 <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 11/09/2015 07:18 PM, Maciej W. Rozycki wrote:

>>> I can check if things still work correctly when routed through libata,
>>> although it'll have to wait a couple of weeks yet at the least as I have
>>> wired my SWARM for hardware debugging, making it not immediately bootable
>>> and I'll be departing soon (i.e. I have no time for complicated fiddling).
>>> The host driver itself is actually in arch/mips/sibyte/swarm/platform.c
>>> BTW.
>>>
>>>   Note to self: it would be nice if physical rather than virtual MMIO
>>> addresses were reported too.
>>
>> Part of the problem is that everybody who is serious about using a Swarm
>> is using PCI PATA/SATA card, so this part receives very little TLC.  I
>> btw. can't test because the controller on my Pass 2 board is broken ...
>
>   I think I've been reasonably serious about my SWARM and despite issues
> elsewhere the onboard PATA interface is a part of the system I've never
> had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's
> still 11MB/s (and one of the 4 generic data movers present in the SoC

    If you measure it with something like 'hdparm -t', the real speed figures 
in the PIO modes would disappoint you. It's usually more like 3 MB/s even in 
PIO4...

> could be used as a DMA engine to offload the CPU if anyone bothered
> implementing that in the HBA driver).

    Oh, that's nice!

MBR, Sergei
