From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH][resend] fix IDE legacy mode resources
Date: Fri, 24 Aug 2007 09:14:42 -0700
Message-ID: <20070824161442.GB15305@kroah.com>
References: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761769AbXHXQQ5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 24, 2007 at 11:55:59AM +0900, Yoichi Yuasa wrote:
> Hi,
> 
> I got the following error on MIPS Cobalt.
> 
> PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
> PCI: Unable to reserve I/O region #3:8@f0000170 for device 0000:00:09.1
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
> pata_via 0000:00:09.1: no available native port
> 
> The legacy mode IDE resources set the following order. 
> 
> pci_setup_device()
>     Legacy mode ATA controllers have fixed addresses.
>     IDE resources: 0x1F0-0x1F7, 0x3F6, 0x170-0x177, 0x376
>     |
>     V
> pcibios_fixup_bus()
>     MIPS Cobalt PCI bus regions have the -0x10000000 offset from PCI resources.
>     pcibios_fixup_bus() fix PCI bus regions.
>     0x1F0 - 0x10000000 = 0xF00001F0
>     |
>     V
> ata_pci_init_one()
>     PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1
> 
> In some architectures, PCI bus regions have the offset from PCI resources.
> For this reason, pci_setup_device() should set PCI bus regions to dev->resource[]. 

I thought this patch was rejected in the past as it broke other
machines.

thanks,

greg k-h
