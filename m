From: Tejun Heo <tj@kernel.org>
Subject: Re: Question about HighPoint RocketRAID 642L SCSI driver conflict
 with Linux AHCI driver
Date: Thu, 4 Jun 2015 14:16:56 +0900
Message-ID: <20150604051656.GO20091@mtj.duckdns.org>
References: <002a01d09e84$22be8f90$683baeb0$@highpoint-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002a01d09e84$22be8f90$683baeb0$@highpoint-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux <linux@highpoint-tech.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Jun 04, 2015 at 01:05:49PM +0800, linux wrote:
> Dear Tejun Heo,
> 
>   This is HighPoint Linux Team. We found Linux AHCI driver since kernel 3.16
> has added ID (0x06421103) to support RocketRAID 642L which is not what we
> expected. If we want to load HighPoint RR642L RAID version Linux SCSI
> driver, it becomes conflict each other. This affects our customers who need
> to use our RAID version driver stack.
>
>   Hence,  this is to ask Linux how to solve this conflict with AHCI driver?
> and why Linux wants to add RR642L ID (0x06421103) into AHCI driver? Is there
> any way to prevent this in the future?

Hmmm... so, you're trying to load a proprietary driver but you're
having problem because in-kernel ahci attaches to the driver?

* If the driver is built-in, putting the proprietary driver before
  ahci in Makefile will make that driver probe before ahci.

* If module, ahci can be unbound by echoing the PCI bus ID to
  /sys/bus/pci/drivers/ahci/unbind and then bind that to the
  proprietary driver.

* Or you can tell pci-stub driver do grab the PCI ID so that ahci
  doesn't probe it at all.  Once the proprietary driver becomes
  available, the device can be rebound to the driver.

Thanks.

-- 
tejun
