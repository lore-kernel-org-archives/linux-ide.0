From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Tue, 19 Jun 2007 15:19:19 +0100
Message-ID: <20070619151919.79c79af1@the-village.bc.nu>
References: <20070618175713.GD5836@austin.ibm.com>
	<20070618212704.394912b8@the-village.bc.nu>
	<20070618204601.GF5836@austin.ibm.com>
	<20070618220441.3a3af8ca@the-village.bc.nu>
	<4677E3BC.3040307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753322AbXFSOO3@vger.kernel.org>
In-Reply-To: <4677E3BC.3040307@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 19 Jun 2007 18:10:04 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Alan Cox wrote:
> >>I can prepare a patch, but only with a lot of guidance. I can test 
> >>& debug, I'm highly motivated just right now ... 
> 
> > If you've got a nice repeatable problem please try using the libata
> > driver. That handles the error paths differently and doesn't try a FIFO
> > drain which might matter in this case I guess.
> 
>     FIFO drain for DMA commands?

Welcome to the old IDE layer which I am so glad I left behind 8)

ide_ata_error will try and do a PIO flush regardless of the command type
if DRQ_STAT is asserted. See ide_dma_intr -> ide_error -> ...

Alan
