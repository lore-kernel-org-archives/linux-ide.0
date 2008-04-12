From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 2/2] libata: power off unused ports
Date: Sat, 12 Apr 2008 00:28:13 -0400
Message-ID: <48003A5D.9000306@garzik.org>
References: <20080325221646.567639335@intel.com> <20080325152813.0b34761f@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37207 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147AbYDLE2P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 00:28:15 -0400
In-Reply-To: <20080325152813.0b34761f@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, arjan@linux.intel.com

Kristen Carlson Accardi wrote:
> If a port doesn't support hot plug, there's no reason to keep the phy powered
> on unoccupied ports.  
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> Index: linux-2.6.25-rc3/drivers/ata/ahci.c
> ===================================================================
> --- linux-2.6.25-rc3.orig/drivers/ata/ahci.c
> +++ linux-2.6.25-rc3/drivers/ata/ahci.c
> @@ -52,6 +52,7 @@
>  static int ahci_enable_alpm(struct ata_port *ap,
>  		enum link_pm policy);
>  static void ahci_disable_alpm(struct ata_port *ap);
> +static int ahci_is_hotplug_capable(struct ata_port *ap);
>  
>  enum {
>  	AHCI_PCI_BAR		= 5,
> @@ -163,6 +164,7 @@ enum {
>  	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
>  	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
> +	PORT_CMD_HPCP		= (1 << 18), /* port is hot plug capable */

Under which conditions is this bit set?

The conclusion reached by this patch seems correct, but I am not sure 
about the premise...

I was under the impression that AHCI ports were hotplug capable, from 
libata's point of view, simply due to the fundamentals of SATA.



Thinking about the bigger pictures, powering off the phy is something we 
want to do in a lot more cases than this, but there is a stumbling 
block:  we wander into the realm of policy.

For most users most of the time, empty SATA ports are needlessly 
powered.  The problem is that, at any given moment, a device may be 
hot-plugged, so we must be ready for that.  We need some way for the 
user to let the driver know that they will not be hotplugging anything 
anytime soon, permitting power savings to be enabled.

A compromise solution that avoids adding a userspace "knob" has also 
been proposed (by Tejun, I think?):  power up the phy every N seconds, 
check for device, power down phy if nothing.  That should provide some 
power savings, though not as much as with a "knob" switched to "hotplug: 
off"

	Jeff


