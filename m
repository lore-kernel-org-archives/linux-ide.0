From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
Date: Mon, 5 Aug 2002 14:10:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10208051335540.11932-100000@master.linux-ide.org>
References: <12CB5AF43EE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <12CB5AF43EE@vcnet.vc.cvut.cz>
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Petr,

Funny reading the code of udma_status in pcidma.c I see nothing that can
report the contents of busmaster register undoctored.  Only udma_stop
returns a binary state or that is all it can do.

Your point about about code familiarity is a lark.

On Mon, 5 Aug 2002, Petr Vandrovec wrote:

> Code ORs read value with 0x10 to make sure that it reports non-zero
> value when error happens (when chip returs dma_stat == 0x00). And 0x10
> was choosen because of this bit should be always zero, as you know.

The only time known when it returns a non 0xE7 maskable value or the inner
bits are set, is when you poke the dma engine when it is BUSY and/or EOT
has not occurred.  So clearly you have broken the EOT checks because
clearly it is not needed in broken host drivers.

Now, to hand you a clue bat!

I have observed this in the port forward into 2.5 also, and have seen
dma_status return on a simplex setup with 0xFF.  Now given that I have
correct EOT checks, and from a brief overview of 2.5 can not tell if
they are exist anymore, it can only mean that events are outside the model
of the DMA State Machine.

The result is if the inner two bits on the top and bottom nibbles are set,
the damn thing is busy and code is wrong on the calling events.


Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 5 Aug 2002, Petr Vandrovec wrote:

> On  5 Aug 02 at 13:08, Andre Hedrick wrote:
> > Bit 7: Simplex RO
> > Bit 6: Device 1 DMA Capable RW
> > Bit 5: Device 0 DMA Capable RW
> > Bit 4: Reserved "MUST RETURN ZERO ON READS" !!!     Vendor Write
> > Bit 3: Reserved "MUST RETURN ZERO ON READS" !!!     Vendor Write
> > Bit 2: Bus Master Interrupt STATUS R Clear W
> > Bit 1: Bus Master Error     STATUS R Clear W
> > Bit 0: Bus Master Active    STATUS
> > 
> > Vendor Write, is not a published or listed techincal term.
> > It is me trying to present this clearly enough so that the masses will see
> > how poorly the general understanding of the basics in 2.5.
> 
> If you'll bother with reading code, you'll find that dma status
> is reported after:
> 
> (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
> 
> Because of same code is used in your 2.4.x ide-dma.c (at least in
> 2.4.19-rc5), I'm really happy that now I know that you are really 
> familiar with your code.
> 
> Code ORs read value with 0x10 to make sure that it reports non-zero
> value when error happens (when chip returs dma_stat == 0x00). And 0x10 
> was choosen because of this bit should be always zero, as you know.
> 
> Maybe we should print value after ANDing with 0xEF, but why? Everybody
> can read code when in doubt.
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
>                                             
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


