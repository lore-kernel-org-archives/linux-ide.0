From: Paul Rolland (=?UTF-8?Q?=E3=83=9D=E3=83=BC=E3=83=AB=E3=83=BB?=
	=?UTF-8?Q?=E3=83=AD=E3=83=A9=E3=83=B3?=) <rol@witbe.net>
Subject: Re: [2.6.22.5] irq X: nobody cared but X is successfully used by
 libata
Date: Sat, 15 Sep 2007 15:38:08 +0200
Message-ID: <20070915153808.424d0fbe@tux.DEF.witbe.net>
References: <20070826203513.4fa35f68@tux.DEF.witbe.net>
	<46E24DE8.4050603@gmail.com>
	<20070909085923.76cebcb1@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755538AbXIONid@vger.kernel.org>
In-Reply-To: <20070909085923.76cebcb1@tux.DEF.witbe.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net
List-Id: linux-ide@vger.kernel.org

Hello,

Just to let you know that this seems to be over in 2.6.23-rc6.
Don't know exactly what fixed it, but it is no more present in my bootlog,
with or without the irqpoll option.

Nice job,
Regards,
Paul

On Sun, 9 Sep 2007 08:59:23 +0200
Paul Rolland <rol@as2917.net> wrote:

> Hello Tejun,
> 
> On Sat, 08 Sep 2007 16:23:20 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
> > Paul Rolland wrote:
> > > Hello,
> > > 
> > > My machine (an ASUS P5W-DH-Deluxe, Core2, 4Go RAM, 3 SATA and 2IDE) is
> > > reporting a :
> > > irq 23: nobody cared (try booting with the "irqpoll" option)
> > > together with a Call Trace, but :
> > >  - irqpoll is present on the command line,
> > >  - the irq is reported to be used by libata,
> > >  - the irqpoll option is mandatory if I want _some_ of my SATA disks to
> > > be accessible.
> > 
> > So, if you don't add the 'irqpoll' option, IO to disks don't work at all
> > after nobody cared message, right?
> 
> IO to disks don't work for SOME disks, but some others are still Ok (I've
> three SATA and two IDE).
> 
> Also, what is weird is the content of dmesg : after the nobody care, it
> looks as if IRQ 23 is reuse for another device (SMBus),
> but /proc/interrupts still reports it being used by libata.
> 
> I've been trying 2.6.23-rc5, and I'm still having this IRQ 23 nobody cared 
> message.
> 
> Regards,
> Paul
> 
> 
> 


-- 
Paul Rolland                                E-Mail : rol(at)witbe.net
Witbe.net SA                                Tel. +33 (0)1 47 67 77 77
Les Collines de l'Arche                     Fax. +33 (0)1 47 67 77 99
F-92057 Paris La Defense                    RIPE : PR12-RIPE

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur 
"Some people dream of success... while others wake up and work hard at it" 

So much
depends
upon
a red

wheel
barrow
glazed with

rain
water
beside
the white
chickens.
		-- William Carlos Williams, "The Red Wheel Barrow"
