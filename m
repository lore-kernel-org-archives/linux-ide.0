From: Ming Zhang <mingz@ele.uri.edu>
Subject: Re: hotplug works, but newly plug not
Date: Thu, 25 May 2006 13:08:25 -0400
Message-ID: <1148576906.2956.81.camel@localhost.localdomain>
References: <1148484316.26093.72.camel@localhost.localdomain>
	 <4474C737.9000600@gmail.com>
	 <1148504987.26093.177.camel@localhost.localdomain>
	 <1148569743.2956.51.camel@localhost.localdomain> <4475C9D6.70904@pobox.com>
	 <1148573052.2956.65.camel@localhost.localdomain>
Reply-To: mingz@ele.uri.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orca.ele.uri.edu ([131.128.51.63]:1489 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1030287AbWEYRIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 May 2006 13:08:46 -0400
In-Reply-To: <1148573052.2956.65.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide-list <linux-ide@vger.kernel.org>

This time I boot with 2 disks in slot. So the IRQ_MASK is set
successfully for 2 ports and left as 0 for another 2 ports.

Ming

========================
May 25 13:00:53 localhost kernel: ahci_setup_port: base now==0xf881c500
May 25 13:00:53 localhost kernel: ahci_setup_port: EXIT
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_CMD 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_SCR_ERR 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_STAT 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_MASK 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: mmio f881c400
port_mmio f881c580
May 25 13:00:53 localhost kernel: ahci_setup_port: ENTER,
base==0xf881c400, port_idx 1
May 25 13:00:53 localhost kernel: ahci_setup_port: base now==0xf881c580
May 25 13:00:53 localhost kernel: ahci_setup_port: EXIT
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_CMD 0x6
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_SCR_ERR 0x4050000
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_STAT 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_MASK
0x7840007f
May 25 13:00:53 localhost kernel: ahci_host_init: mmio f881c400
port_mmio f881c600
May 25 13:00:53 localhost kernel: ahci_setup_port: ENTER,
base==0xf881c400, port_idx 2
May 25 13:00:53 localhost kernel: ahci_setup_port: base now==0xf881c600
May 25 13:00:53 localhost kernel: ahci_setup_port: EXIT
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_CMD 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_SCR_ERR 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_STAT 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_MASK 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: mmio f881c400
port_mmio f881c680
May 25 13:00:53 localhost kernel: ahci_setup_port: ENTER,
base==0xf881c400, port_idx 3
May 25 13:00:53 localhost kernel: ahci_setup_port: base now==0xf881c680
May 25 13:00:53 localhost kernel: ahci_setup_port: EXIT
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_CMD 0x6
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_SCR_ERR 0x4050000
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_STAT 0x0
May 25 13:00:53 localhost kernel: ahci_host_init: PORT_IRQ_MASK
0x7840007f
May 25 13:00:53 localhost kernel: ahci_host_init: HOST_CTL 0x80000000
May 25 13:00:53 localhost kernel: ahci_host_init: HOST_CTL 0x80000002


On Thu, 2006-05-25 at 12:04 -0400, Ming Zhang wrote:
> I added these 2 lines in ahci_host_init()
> 
>                 writel(1 << i, mmio + HOST_IRQ_STAT);
> 
>                 /* set irq mask (enables interrupts) */
>                 writel(DEF_PORT_IRQ, port_mmio + PORT_IRQ_MASK);
> 
> ~~~~~~code i added
>                 tmp = readl(port_mmio + PORT_IRQ_MASK);
>                 VPRINTK("PORT_IRQ_MASK 0x%x\n", tmp);
> ~~~~~~~~~~~~~
> 
> And I got this dmesg with VPRINTK enabled in libata.h. Does this mean
> that IRQ is not enabled on this port at all?
> 
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> ahci 0000:00:1f.2: pcs 0x8f->0x8f
> ahci_host_init: cap 0xc720ff03  port_map 0x0  n_ports 4
> ahci_host_init: mmio f8820400  port_mmio f8820500
> ahci_setup_port: ENTER, base==0xf8820400, port_idx 0
> ahci_setup_port: base now==0xf8820500
> ahci_setup_port: EXIT
> ahci_host_init: PORT_CMD 0x0
> ahci_host_init: PORT_SCR_ERR 0x0
> ahci_host_init: PORT_IRQ_STAT 0x0
> ahci_host_init: PORT_IRQ_MASK 0x0
> ahci_host_init: mmio f8820400  port_mmio f8820580
> ahci_setup_port: ENTER, base==0xf8820400, port_idx 1
> ahci_setup_port: base now==0xf8820580
> ahci_setup_port: EXIT
> ahci_host_init: PORT_CMD 0x0
> ahci_host_init: PORT_SCR_ERR 0x0
> ahci_host_init: PORT_IRQ_STAT 0x0
> ahci_host_init: PORT_IRQ_MASK 0x0
> ...
> 
> 
> On Thu, 2006-05-25 at 11:14 -0400, Jeff Garzik wrote:
> > Ming Zhang wrote:
> > > I read the whole AHCI but I still could not find out what is the magic
> > > number 0x92. Is this in some Intel doc?
> > 
> > AHCI spec only documents generic PCI config registers.  Each vendor has 
> > their own vendor-specific registers.  Intel's are documented publicly on 
> > the developer website.
> > 
> > 	Jeff
> > 
> > 
> > 
> 

