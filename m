From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v5 0/2] ahci: Add generic MSI-X support for single
 interrupts to SATA PCI
Date: Tue, 16 Jun 2015 15:24:34 +0200
Message-ID: <20150616132434.GO10428@rric.localhost>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433526566-21136-1-git-send-email-rric@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <rric@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 05.06.15 19:49:24, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> This patch set adds generic support for MSI-X interrupts to the SATA
> PCI driver.
> 
> One patch does the generic change, the other add support for Cavium's
> ThunderX host controller.

Tejun,

any comment on this?

Thanks,

-Robert

> 
> 
> Robert Richter (2):
>   ahci: Add generic MSI-X support for single interrupts to SATA PCI
>     driver
>   ahci: Add support for Cavium's ThunderX host controller
> 
>  drivers/ata/ahci.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
> 
> -- 
> 2.1.1
> 
