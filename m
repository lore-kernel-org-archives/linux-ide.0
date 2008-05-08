From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Fri, 9 May 2008 00:37:13 +0100
Message-ID: <20080508233713.GB15377@srcf.ucam.org>
References: <20080508161008.59361de5@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932203AbYEHXhw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080508161008.59361de5@appleyard>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, May 08, 2008 at 04:10:08PM -0700, Kristen Carlson Accardi wrote:

> +static int ahci_is_hotplug_capable(struct ata_port *ap)
> +{
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u8 cmd;
> +
> +	if (!ahci_power_save)
> +		return 1;
> +
> +	cmd = readl(port_mmio + PORT_CMD);
> +	return ((cmd & PORT_CMD_HPCP) || (cmd & PORT_CMD_ESP));
> +}

Just out of interest, is this set on laptop bays? (Are any of those even 
native SATA yet?)
-- 
Matthew Garrett | mjg59@srcf.ucam.org
