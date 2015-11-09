From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
Date: Mon, 9 Nov 2015 22:08:28 +0300
Message-ID: <5640EF2C.40907@cogentembedded.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
 <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org>
 <20151109144932.GE22591@linux-mips.org>
 <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
 <5640D8E9.7080808@cogentembedded.com>
 <alpine.LFD.2.20.1511091827480.10231@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:32960 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbKITId (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2015 14:08:33 -0500
Received: by lbbkw15 with SMTP id kw15so99969544lbb.0
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2015 11:08:31 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1511091827480.10231@eddie.linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/09/2015 09:54 PM, Maciej W. Rozycki wrote:

>>>    I think I've been reasonably serious about my SWARM and despite issues
>>> elsewhere the onboard PATA interface is a part of the system I've never
>>> had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's
>>> still 11MB/s (and one of the 4 generic data movers present in the SoC
>>
>>     If you measure it with something like 'hdparm -t', the real speed figures
>> in the PIO modes would disappoint you. It's usually more like 3 MB/s even in
>> PIO4...

>   Well, various factors contribute to actual figures possible to achieve,
> the physical medium transfer speed being an important one.

    Yes, of course. Yet even with MWDMA2 (same wire speed as PIO4) hdparm 
shows about an order of magnitude higher speeds, IIRC. With the UltraDMA modes 
it becomes even higher...

> That 11MB/s
> throughput is the maximum you can ever get on the wire in PIO 3, assuming
> data is already available to transfer and IORDY is asserted right away
> every cycle.

    Yes, I figured.

[...]

>    Maciej

MBR, Sergei

