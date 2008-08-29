From: Thomas Renninger <trenn@suse.de>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Fri, 29 Aug 2008 15:11:00 +0200
Message-ID: <200808291511.02062.trenn@suse.de>
References: <48A35FE6.1080903@tlinx.org> <200808291339.59785.trenn@suse.de> <48B7E573.60601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <48B7E573.60601@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Friday 29 August 2008 14:02:59 Tejun Heo wrote:
> Thomas Renninger wrote:
> > On Friday 29 August 2008 12:20:14 Tejun Heo wrote:
> >> Thomas Renninger wrote:
...
> > where pci=noacpi helped. IMO not worth an automated detection.
> > Especially for those old machines..., people know which param to use, you
> > will produce more grief than any good.
> >
> > There were several acpipnp problems recently, but this is another topic
> > and that needs fixing anyway, Bjorn is doing a real good job here.
>
> Hmm... Maybe what's necessary it to detect IRQ misrouting and turn on
> irqpoll on the specific IRQ (or IRQ handler), which would help 'nobody
> cared' cases too.
But you risk that things never get fixed correctly.
At least yell loudly at the user that things must get fixed.
IMO the a message (you already see appearing?) at the right place:
try irqpoll, try xyz param is enough.

The current behavior is not that bad and not that much machines
(at least new machines) are affected, but as said I am not
deeply involved in PCI/IRQ things.

      Thomas
