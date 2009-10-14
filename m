From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Wed, 14 Oct 2009 12:53:44 +0100
Message-ID: <20091014125344.7d0b2597@lxorguk.ukuu.org.uk>
References: <m3my46yo5g.fsf@intrepid.localdomain>
	<19147.28614.505296.752363@pilspetsen.it.uu.se>
	<m3vdii51d8.fsf@intrepid.localdomain>
	<19157.6679.939371.469696@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758706AbZJNLxS@vger.kernel.org>
In-Reply-To: <19157.6679.939371.469696@pilspetsen.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: linux-ide@vger.kernel.org

> I guess you didn't see Alan Cox' recent comment about the vt6421:
> <http://marc.info/?l=linux-ide&m=125526699500519&w=2>.
> 
> You should probably look for a mini-PCI card with a different chipset.

Docs have appeared - whether they will help tie it down completely I
don't know.

>  > -RAID bus controller: VT6421 IDE RAID Controller (rev 50)
>  > +IDE interface: VT6421 IDE RAID Controller (rev 50) (prog-if 8f [Master
>  >          SecP SecO PriP PriO])

That shouldn't matter of itself - its basically header differences
>  > 
>  > -        Control: Mem- FastB2B+ ...
>  > +        Control: Mem+ FastB2B- ...
>  > 
>  > Mem - I guess x86-64 enables it for BIOS access. This is the only PCI
>  > device in machine A (ARM).
>  > 
>  > -        Latency: 32
>  > +        Latency: 64

These two may be worth playing with, especially latency. Forcing the
latency on the problem board would be interesting given that it is a DMA
transfer that is failing.
