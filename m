From: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Assorted bugs in the PIIX drivers
Date: Fri, 25 Nov 2005 16:36:01 +0100
Message-ID: <20051125153601.GA6814@stiffy.osknowledge.org>
References: <1132929808.3298.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161119AbVKYPf6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1132929808.3298.18.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2005-11-25 14:43:28 +0000]:

> I finally got all the documents rounded up to try and redo Jgarzik's
> PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)
> 
> I then started reading the docs and the code and noticing a couple of
> problems
> 
> 1.	We set IE1 on PIO0-2 which the docs say is for PIO3+
> 
> 2.	The ata_piix one (but not the ide/pci one) have shifts wrong so that
> the secondary slave timings are half loaded into the primary slave
> 
> 
> I'm also not clear if the "no MWDMA0" list has been updated correctly
> for the newer chipsets.
> 
> I've yet to review the DMA programming, just the PIO so far.

Alan,

	could it be possible to again drop the ide=nodma kernel parameter in my
configs that use reiserfs? reiserfs just bails out when I mount devices on ide
busses that miss that parameter. I somtimes had to --rebuild-tree after a boot
with DMA enabled.

Regards,
	Marc
