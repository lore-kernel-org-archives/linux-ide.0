From: James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
Date: Wed, 20 Oct 2004 11:29:05 +0100 (BST)
Sender: kernelnewbies-bounce@nl.linux.org
Message-ID: <Pine.LNX.4.44.0410201126480.5805-100000@beast.stev.org>
References: <Pine.LNX.4.44.0410171837280.22150-100000@beast.stev.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernelnewbies-bounce@nl.linux.org>
In-Reply-To: <Pine.LNX.4.44.0410171837280.22150-100000@beast.stev.org>
Errors-to: kernelnewbies-bounce@nl.linux.org
List-help: <mailto:ecartis@nl.linux.org?Subject=help>
List-unsubscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:kernelnewbies-request@nl.linux.org?Subject=subscribe>
List-owner: <mailto:ecartis-owner@nl.linux.org>
List-post: <mailto:kernelnewbies@nl.linux.org>
List-archive: <http://mail.nl.linux.org/kernelnewbies/>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ian Pilcher <i.pilcher@comcast.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
List-Id: linux-ide@vger.kernel.org


just to let anyone know if you were following this i replaced the
promise ata/133 card with a highpoint card and now strangly everything 
works fine.

I also found various places on the internet that suggest promise actually 
limit there card and make 3 of them not work toether in an attempt to 
force you to buy there larger more expensive raid5 cards (8 channel).

	James

> > > i did actually kind of get the card's working together but ran into
> > > another problem.
> > > 
> > > when i boot with ide=nodma and then turn on dma manually on all the other
> > > cards / board chipset etc... they all function fine
> > > 
> > > then i can only turn the dma up to ATA/100 if i set it to ata/133 it will
> > > cause the errors. I assume this is something todo with the promise bois
> > > not setting up the 3rd card at boot time. It only shows drive listing for
> > > 2 of the 3 cards.
> > 
> > There were very similar problems reported in the past and they were
> > fixed by replacing power supply with a better one.
> 
> I dont beleave the power supply to be a problem here. Since the problem
> is local to just this 1 card. No matter where i place it on the pci bus
> or swap it with the other promise cards the 3rd promise card on the bus 
> always fails. I have placed this also below / above a network card + scsi 
> card in the same machine. A volt meter on the power supply is giving 
> correct results. If the power supply was to be failing under load would 
> this not leed to more unpredictable lockups ?
> 
> eg running both commands at the same time.
> cat /dev/zero > /dev/hdi
> cat /dev/zero > /dev/hdk
> will not cause a lockup
> 
> cat /dev/zero > /dev/hdm
> cat /dev/zero > /dev/hdo
> 
> will always cause a lockup with as soon as the disks start writing.
> I have tried with all combinations of the disks / cables.
> 
> running a single command cat /dev/zero > /dev/hdm will not cause a lockup
> nor will the other command. Only when they are both running together will
> it cause a problem. I can even run
> cat /dev/zero > /dev/hdi
> cat /dev/zero > /dev/hdk
> cat /dev/zero > /dev/hdm
> together without causing a lockup.
> hdi and hdk are located on the 2nd promise card. hdm hdo are on the 3rd 
> card.
>  
> > Also you shouldn't need to use "ide=nodma" and play with hdparm,
> > driver should tune the best mode available.  If this doesn't work then
> > something needs fixing.
> 
> > You can find out if BIOS/driver configures cards correctly by
> > comparing PCI config space (lspci -xxx) for working/non-working
> > controller.
> 
> The output of the 3 cards matches except for the memory address.
>  
> 
> 	James
> 
> > > Unfortunatly this generated another problem.
> > > When read from both drives at the same time it functions normally and
> > > see resonable performance. When i attempt to write to both drives it will
> > > cause the machine to lockup.
> > > 
> > >         James
> > > 
> > > 
> > > 
> > > On Thu, 14 Oct 2004, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > > On Thu, 14 Oct 2004 13:12:42 -0500, Ian Pilcher <i.pilcher@comcast.net> wrote:
> > > > > James Stevenson wrote:
> > > > > >
> > > > > > i seem to have run into an annoying problem with a machine which has
> > > > > > 3 promise ata/133 card the PDC20269 type.
> > > > > >
> > > > >
> > > > > ....
> > > > >
> > > > > >
> > > > > > Does anyone have an explenation of why this can happen ?
> > > >
> > > > * check power supply
> > > > * compare PCI config space of the "failing" controller to the one which
> > > >   is "working" (assuming that identical devices are connected to each),
> > > >   maybe firmware/driver forgets to setup some settings
> > > >
> > > > > Promise cards don't support more than two per machine.  If you can get a
> > > > > third card to work in PIO mode, consider it an added (but unsupported)
> > > > > bonus.
> > > >
> > > > AFAIR people have been running 4-5 cards just fine
> 
> 

-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
 11:20am  up 18:18,  4 users,  load average: 3.39, 1.38, 0.51


--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/
