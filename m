From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Sat, 20 Oct 2007 18:55:29 +0400
Message-ID: <471A16E1.50905@ru.mvista.com>
References: <200710142211.03382.marogge@onlinehome.de> <200710192158.03836.marogge@onlinehome.de> <471912EF.4020208@ru.mvista.com> <200710200109.58872.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:60817 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755585AbXJTOzT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 10:55:19 -0400
In-Reply-To: <200710200109.58872.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Rogge <marogge@onlinehome.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Hello.

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

    How comes it's "Memory" and not "I/O ports"?!  Looks like something is 
wrong in either lspci itself or where it fetches the data from...

>         I/O ports at d800 [disabled] [size=16]

> 00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01) 
> (prog-if 00 [UHCI])
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at d400 [size=32]
> 
> 00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
>         Flags: medium devsel, IRQ 9
> 
> 00:07.0 IDE interface: Silicon Image, Inc. PCI0648 (rev 01) (prog-if 8f 
> [Master SecP SecO PriP PriO])

    Yeah, that's exactly PCI-648 revision 1 that was described in the spec.
Well, I'll send you a patch to try soon...

MBR, Sergei
