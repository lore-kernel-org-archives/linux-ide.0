From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
Date: Mon, 5 Aug 2002 22:31:20 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <12CB5AF43EE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On  5 Aug 02 at 13:08, Andre Hedrick wrote:
> Bit 7: Simplex RO
> Bit 6: Device 1 DMA Capable RW
> Bit 5: Device 0 DMA Capable RW
> Bit 4: Reserved "MUST RETURN ZERO ON READS" !!!     Vendor Write
> Bit 3: Reserved "MUST RETURN ZERO ON READS" !!!     Vendor Write
> Bit 2: Bus Master Interrupt STATUS R Clear W
> Bit 1: Bus Master Error     STATUS R Clear W
> Bit 0: Bus Master Active    STATUS
> 
> Vendor Write, is not a published or listed techincal term.
> It is me trying to present this clearly enough so that the masses will see
> how poorly the general understanding of the basics in 2.5.

If you'll bother with reading code, you'll find that dma status
is reported after:

(dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;

Because of same code is used in your 2.4.x ide-dma.c (at least in
2.4.19-rc5), I'm really happy that now I know that you are really 
familiar with your code.

Code ORs read value with 0x10 to make sure that it reports non-zero
value when error happens (when chip returs dma_stat == 0x00). And 0x10 
was choosen because of this bit should be always zero, as you know.

Maybe we should print value after ANDing with 0xEF, but why? Everybody
can read code when in doubt.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
