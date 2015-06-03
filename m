From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 2/3] ahci: Store irq number in struct ahci_host_priv
Date: Wed, 3 Jun 2015 14:39:05 +0900
Message-ID: <20150603053905.GC20091@mtj.duckdns.org>
References: <1433073319-13796-1-git-send-email-rric@kernel.org>
 <1433073319-13796-3-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433073319-13796-3-git-send-email-rric@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>
List-Id: linux-ide@vger.kernel.org

On Sun, May 31, 2015 at 01:55:18PM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> Currently, ahci supports only msi and intx. To also support msix the
> handling of the irq number need to be changed. The irq number for msix
> devices is taken from msi_list instead of pci_dev. Thus, the irq
> number of a device needs to be stored in struct ahci_host_priv now.
> This allows the host controller to be activated in a generic way.
> 
> This change is only intended for ahci drivers. For that reason the irq
> number is stored in struct ahci_host_priv used only by ahci drivers.
> Thus, the ABI changes only for ahci_host_activate(), but existing ata
> drivers (about 50) are unaffected and keep unchanged. All users of
> ahci_host_activate() have been updated.
> 
> While touching drivers/ata/libahci.c, doing a small code cleanup in
> ahci_port_start().
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Applied 1-2 to libata/for-4.2.

Thanks.

-- 
tejun
