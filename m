From: Jeff Garzik <garzik@gtf.org>
Subject: Re: IO/MMIO 2.4 ATA/IDE driver recore near complete
Date: Sun, 19 May 2002 10:58:43 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020519105843.B10528@gtf.org>
References: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org> <20020519103323.GA28335@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20020519103323.GA28335@sci.fi>; from as@sci.fi on Sun, May 19, 2002 at 01:33:24PM +0300
List-Id: linux-ide@vger.kernel.org
To: Anssi Saari <as@sci.fi>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, May 19, 2002 at 01:33:24PM +0300, Anssi Saari wrote:
> I wonder if this would help me with my audio CD writing problem which
> seems to use PIO mode and slow my system to a snails pace?

Nope.  It depends on your ATA controller, and the vast majority of
controllers currently on the market use PIO.

You are thinking about PIO versus DMA, which are the two data transfer
modes of ATA.  We are talking about a situation which replaces PIO with
MMIO, but otherwise looks and acts similarly to PIO+DMA.

	Jeff



