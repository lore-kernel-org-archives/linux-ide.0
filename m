From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 01 Aug 2007 22:19:44 +0400
Message-ID: <46B0CEC0.60504@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost>	 <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>	 <200707312332.10820.bzolnier@gmail.com>  <46B08D63.4040205@ru.mvista.com>	 <1185983536.16340.3.camel@orchid.arb.net>  <46B0ADB6.60207@ru.mvista.com> <1185988529.16340.5.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25700 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751174AbXHASRq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 14:17:46 -0400
In-Reply-To: <1185988529.16340.5.camel@orchid.arb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bob Ham wrote:

>>>>>>>>>I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
>>>>>>>>>a while now, using a proprietary binary driver from Highpoint in a linux
>>>>>>>>>2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
>>>>>>>>>boot, as reported by others.

>>>>>>>> Can we see a bootlog please?

>>>>>>>  ... and the output of 'lspci -v' too.

>>>>   If possible, turn off that driver, 
>>>>then post that output...

>>>This is the output of the boot using the pata_hpt37x driver:

>>    Hrm... what I asked for was 'lspci -v' output. :-)

>>lspci gives:

>>00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>>        Subsystem: Triones Technologies, Inc. Unknown device 0001
>>        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>>        I/O ports at efa0 [size=8]
>>        I/O ports at ef9c [size=4]
>>        I/O ports at ef90 [size=8]
>>        I/O ports at ef98 [size=4]
>>        I/O ports at ec00 [size=256]
>>        Expansion ROM at fe700000 [disabled] [size=128K]
>>        Capabilities: [60] Power Management version 2
>>
>>00:0d.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
>>        Subsystem: Triones Technologies, Inc. Unknown device 0001
>>        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>>        I/O ports at eff0 [size=8]
>>        I/O ports at efe4 [size=4]
>>        I/O ports at efa8 [size=8]
>>        I/O ports at efe0 [size=4]
>>        I/O ports at ed00 [size=256]
>>        Capabilities: [60] Power Management version 2

    Too bad, this is the standard HPT subsystem ID of 0x0001... So, nothing 
comes to my mind other than add a module parameter to hpt366.c to specify that 
we're using the crippled SATA bridge... well, maybe it would also make sense 
to scan the BIOS for the signatures...

WBR, Sergei
