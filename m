From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Sat, 20 Oct 2007 21:11:56 +0400
Message-ID: <471A36DC.4040509@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de> <200710192158.03836.marogge@onlinehome.de> <471912EF.4020208@ru.mvista.com> <200710200109.58872.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:61394 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756554AbXJTRLq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 13:11:46 -0400
In-Reply-To: <200710200109.58872.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Martin Rogge wrote:

> 00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) 
> (prog-if 80 [Master])
>         Flags: medium devsel
>         [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] 
> [size=8]
>         [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] 
> [size=1]
>         [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] 
> [size=8]
>         [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] 
> [size=1]
>         I/O ports at d800 [disabled] [size=16]

[...]

> 00:07.0 IDE interface: Silicon Image, Inc. PCI0648 (rev 01) (prog-if 8f 
> [Master SecP SecO PriP PriO])
>         Subsystem: ASUSTeK Computer Inc. CUBX motherboard
>         Flags: bus master, medium devsel, latency 64, IRQ 15
>         I/O ports at d000 [size=8]
>         I/O ports at b800 [size=4]
>         I/O ports at b400 [size=8]
>         I/O ports at b000 [size=4]
>         I/O ports at a800 [size=16]
>         Capabilities: [60] Power Management version 1

    What I don't like is that both PIIX4 and PCI-648 are sharing IRQ15 (PIIX4 
is in legacy mode, so it uses edge-triggered IRQ15 which is not shareable). 
You don't have drives connected to PIIX4, do you?  However, it doesn't look
like a glitch on IRQ15, it looks like MRDMODE reg. doesn't work as documented...

> cu Martin

MBR, Sergei
