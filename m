From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/2] libata: power off unused ports
Date: Mon, 14 Apr 2008 16:11:22 -0700
Message-ID: <20080414161122.03b2211d@appleyard>
References: <20080325221646.567639335@intel.com>
	<20080325152813.0b34761f@appleyard>
	<48003A5D.9000306@garzik.org>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13287 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbYDNXRj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Apr 2008 19:17:39 -0400
In-Reply-To: <48003A5D.9000306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, arjan@linux.intel.com

On Sat, 12 Apr 2008 00:28:13 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Kristen Carlson Accardi wrote:
> > If a port doesn't support hot plug, there's no reason to keep the phy powered
> > on unoccupied ports.  
> > 
> > Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > 
> > Index: linux-2.6.25-rc3/drivers/ata/ahci.c
> > ===================================================================
> > --- linux-2.6.25-rc3.orig/drivers/ata/ahci.c
> > +++ linux-2.6.25-rc3/drivers/ata/ahci.c
> > @@ -52,6 +52,7 @@
> >  static int ahci_enable_alpm(struct ata_port *ap,
> >  		enum link_pm policy);
> >  static void ahci_disable_alpm(struct ata_port *ap);
> > +static int ahci_is_hotplug_capable(struct ata_port *ap);
> >  
> >  enum {
> >  	AHCI_PCI_BAR		= 5,
> > @@ -163,6 +164,7 @@ enum {
> >  	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
> >  	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
> >  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
> > +	PORT_CMD_HPCP		= (1 << 18), /* port is hot plug capable */
> 
> Under which conditions is this bit set?
> 
> The conclusion reached by this patch seems correct, but I am not sure 
> about the premise...
> 
> I was under the impression that AHCI ports were hotplug capable, from 
> libata's point of view, simply due to the fundamentals of SATA.

The HPCP bit is set by the BIOS to indicate policy for that port.
For example, a server may set this bit to indicate that there are
removable drive bays on it.  A laptop may not set this bit because nobody
is going to open it up and yank out the cable while it's running.  It is
safe to use this bit to figure out whether or not it's worth checking
for hot plug events on that port in practice, although you are right it
is physically possible for us to still do hot plug if we just pop open
the machine and go for it.

> 
> 
> 
> Thinking about the bigger pictures, powering off the phy is something we 
> want to do in a lot more cases than this, but there is a stumbling 
> block:  we wander into the realm of policy.
> 
> For most users most of the time, empty SATA ports are needlessly 
> powered.  The problem is that, at any given moment, a device may be 
> hot-plugged, so we must be ready for that.  We need some way for the 
> user to let the driver know that they will not be hotplugging anything 
> anytime soon, permitting power savings to be enabled.
> 
> A compromise solution that avoids adding a userspace "knob" has also 
> been proposed (by Tejun, I think?):  power up the phy every N seconds, 
> check for device, power down phy if nothing.  That should provide some 
> power savings, though not as much as with a "knob" switched to "hotplug: 
> off"
> 
> 	Jeff
> 
>

I think that for the common case - we should use HPCP to determine if
the suggested use of the port is for hot plug.  I can see your point
about wanting to give the user the option to just disregard the intended
use of the port and do what they want, but I say we don't make that
the default behavior.  And, I don't like the idea of adding another
wakeup in the driver to do polling - seems like 99% of users are
going to be just fine with a knob - and that they should only
have to use the knob to override the default (or how bout a 
module param?).  I don't think we should compromise power for a 
feature that most people are unlikely to use (if HPCP is not set).
 
