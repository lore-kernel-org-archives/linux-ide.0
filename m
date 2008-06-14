From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk
	Extreme III 8GB
Date: Sat, 14 Jun 2008 12:00:55 +0900
Message-ID: <20080614120055.ad8fbee0.komurojun-mbn@nifty.com>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>
	<20080528222740.GB20893@isilmar.linta.de>
	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>
	<20080607223716.7d142072.komurojun-mbn@nifty.com>
	<20080611072029.GB28692@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20080611072029.GB28692@comet.dominikbrodowski.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>, linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, jgarzik@redhat.com
List-Id: linux-ide@vger.kernel.org

Dear Tejun

> > > > > pcmcia: registering new device pcmcia1.1
> > > > > 1.1: GetNextTuple: No more items
> > > > > pata_pcmcia: probe of 1.1 failed with error -12

The patch "libata: kill hotplug related race condition"
introduced the pata_pcmcia error.

Please fix this problem.


Best Regards
Komuro

> > f046519fc85a8fdf6a058b4ac9d897cdee6f3e52 is first bad commit
commit f046519fc85a8fdf6a058b4ac9d897cdee6f3e52
Author: Tejun Heo <htejun@gmail.com>
Date:   Mon May 19 01:15:08 2008 +0900

    libata: kill hotplug related race condition
    
    Originally, whole reset processing was done while the port is frozen
    and SError was cleared during @postreset().  This had two race
    conditions.  1: hotplug could occur after reset but before SError is
    cleared and libata won't know about it.  2: hotplug could occur after
    all the reset is complete but before the port is thawed.  As all
    events are cleared on thaw, the hotplug event would be lost.
    

> > > > > pcmcia: registering new device pcmcia1.0
> > > > ...
> > > > > pcmcia: registering new device pcmcia1.1
> > > > > 1.1: GetNextTuple: No more items
> > > > > pata_pcmcia: probe of 1.1 failed with error -12
> > 
> > This problem is introduced at kernel 2.6.26-rc4.
> > 
> > The kernel 2.6.26-rc3 does not have this problem.
> 
> 
> git-diff drivers/pcmcia is empty for 2.6.26-rc3 to 2.6.26-rc4. Therefore,
> it looks like something in the ata codepaths introduced this error? Tejun,
> Jeff, any ideas? (original bugreport below)
> 
> Thanks,
> 	Dominik
> 
> > > > Hi,
> > > > 
> > > > > Ive added the id123 strings for a Sandisk Extreme III 8GB.
> > > > > I get this when using pcmcia->CF adapter.
> > > > 
> > > > > pcmcia: registering new device pcmcia1.0
> > > > ...
> > > > > pcmcia: registering new device pcmcia1.1
> > > > > 1.1: GetNextTuple: No more items
> > > > > pata_pcmcia: probe of 1.1 failed with error -12
> > > > 
> > > > Is that a multifunction device? It seems to me that something is broken in
> > > > the device CIS, for both drives seem to be exported already by device
> > > > pcmcia1.0.
> > > 
> > > Its a simply pcmcia->CF adapter and the CF card is a simple storage one. I got it to work through USB-adapter after replacing my
> > > broken one.
> > > However it still doesnt work through the pcmcia->CF adapter.
> > > 
> > > Im not ruling out that its broken though.
> > > 
> > > > 
> > > > Best,
> > > > 	Dominik
