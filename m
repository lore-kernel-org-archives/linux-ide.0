From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 16:04:15 +0200
Message-ID: <200906221604.17915.elendil@planet.nl>
References: <200906211446.38598.elendil@planet.nl> <200906220843.14337.elendil@planet.nl> <200906221321.44672.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906221321.44672.bzolnier@gmail.com>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 22 June 2009, you wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: fix handling of unexpected IRQs vs request_irq()
>
> Add ide_host_enable_irqs() helper and use it in ide_host_register()
> before registering ports.  Then remove no longer needed IRQ unmasking
> from in init_irq().
>
> This should fix the problem with "screaming" shared IRQ on the first
> port (after request_irq() call while we have the unexpected IRQ pending
> on the second port) which was uncovered by my rework of the serialized
> interfaces support.

Thanks Bart. This does solve the "nobody cared" problem.
Tested-by: Frans Pop <elendil@planet.nl>

I also tested it without David's initial patch (i.e. *with* 
IDE_HFLAG_SERIALIZE in host-flags) and that seems to work fine too:
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14 (serialized)
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (serialized)

No idea whether serialized is to be preferred or not. Guess that's David's 
call now.


I do still get the "bad DMA info in identify block" error for the CD 
drive, so that's still a regression relative to 2.6.26:
 hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
-hdd: MWDMA2 mode selected
+hdd: bad DMA info in identify block
+hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4

Cheers,
FJP
