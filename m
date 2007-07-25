From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Wed, 25 Jul 2007 23:16:12 +0400
Message-ID: <46A7A17C.8090505@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <46A79F14.9040409@freescale.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Scott Wood wrote:

>>> +    hwif->hw.io_ports[IDE_DATA_OFFSET] = port;
>>> +
>>> +    port += (1 << pdata->ioport_shift);
>>> +    for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET;
>>> +         i++, port += (1 << pdata->ioport_shift))
>>
>>
>>
>>     Looks like shift doesn't buy as anything, why not just use stride?

> It doesn't buy us anything in here, but it's conceivable that someone 
> may want to write a driver that uses a shift in the I/O accessor rather 
> than an array of port offsets,

    It wouldn't be IDE driver then, and neither it would be libata which also 
does this another way this (despite pata_platform uses shifts too -- not in 
the accessors, so no speed loss).

> and it's easier to convert a shift to a stride than the other way around
 > (not all architectures have an
> equivalent of the cntlzw innstruction, and shift makes it clear that the 
> stride must be power-of-two).  Plus, using shift is consistent with what 
> we do on ns16550.

    Why the heck should we care about the UART code taling about IDE?!
    So, let me consider your argument purely speculative and invalid. ;-)

> -Scott

WBR, Sergei
