From: Thomas Renninger <trenn@suse.de>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Fri, 29 Aug 2008 15:31:20 +0200
Message-ID: <200808291531.22706.trenn@suse.de>
References: <48A35FE6.1080903@tlinx.org> <200808291511.02062.trenn@suse.de> <48B7F710.8080007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <48B7F710.8080007@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Friday 29 August 2008 15:18:08 Tejun Heo wrote:
> Thomas Renninger wrote:
> >>> There were several acpipnp problems recently, but this is another topic
> >>> and that needs fixing anyway, Bjorn is doing a real good job here.
> >>
> >> Hmm... Maybe what's necessary it to detect IRQ misrouting and turn on
> >> irqpoll on the specific IRQ (or IRQ handler), which would help 'nobody
> >> cared' cases too.
> >
> > But you risk that things never get fixed correctly.
> > At least yell loudly at the user that things must get fixed.
> > IMO the a message (you already see appearing?) at the right place:
> > try irqpoll, try xyz param is enough.
>
> Yeah, the kernel should scream like hell but keep working after screaming.
>
> > The current behavior is not that bad and not that much machines
> > (at least new machines) are affected, but as said I am not
> > deeply involved in PCI/IRQ things.
>
> The thing is IRQ storms occassionally happen on otherwise working
> machines taking down the IRQ and all the devices running off the IRQ, so
> it's not as cut and dry as boot or no boot.
AFAIK legacy IRQs can be routed somewhere else (below 16 while the APIC IRQ is 
somewhere above), thus the IRQ may happen twice. Sounds a bit like what you 
explained above.
At least I remember such a very specific problem from the
Real Time people.
(could eventually be switched off by very chipset specific quirks)

Anyway, this starts to get off topic and I am really the wrong one
to answer such questions, others probably know much more about this
than I do.

   Thomas
