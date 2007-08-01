From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver
Date: Wed, 01 Aug 2007 16:39:32 +0400
Message-ID: <46B07F04.8040806@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com> <46A7A17C.8090505@ru.mvista.com> <46A7A1D5.7020003@freescale.com> <46A7A5E4.4090105@ru.mvista.com> <d04530fcd6e879e0bc059049b7951aef@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23466 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751222AbXHAMhe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 08:37:34 -0400
In-Reply-To: <d04530fcd6e879e0bc059049b7951aef@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Segher Boessenkool wrote:

>>     This doesn't mean that shift is better anyway. If everyone 
>> considers it
>> better, I give up. But be warned that shift (stride) is not the only 
>> property
>> characterizing register accesses -- the regs might be only accessible as
>> 16/32-bit quantities, for example (16-bit is a real world example -- from
>> Amiga or smth of that sort, IIRC).

> More importantly, "reg-shift" doesn't say what part of
> the bigger words to access.  A common example is byte-wide
> registers on a 32-bit-only bus; it's about 50%-50% between
> connecting the registers to the low byte vs. connecting it
> to the byte with the lowest address.

    We already have "big-endian" prop used in MPIC nodes, IIRC. Could try to 
"reuse" it here as well...

> The only realistic way to handle all this is to put some
> knowledge into the device driver.  This does of course
> also mean that no "reg-shift" property is needed; the
> device driver can look at your "compatible" property,
> instead.

>>>>    Why the heck should we care about the UART code taling about IDE?!

>>> Consistency?

>>     We're not obliged to be consistent with every piece of the kernel 
>> code.

> It would be nice to not name similar properties in the
> device tree dissimilarly.  Kernel code doesn't come into
> the picture here.

    The "reg-shift" prop is yet unaccepted ad-hockery at this point. ;-)
    So, I don't see why we have to be consistent with it.

> Segher

WBR, Sergei
