From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/4] ata: ahci_brcmstb: disable DIPM support
Date: Fri, 8 Jan 2016 11:30:36 -0500
Message-ID: <20160108163036.GR1898@mtj.duckdns.org>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-3-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452211413-1350-3-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Danesh Petigara <dpetigara@broadcom.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 07, 2016 at 04:03:31PM -0800, Florian Fainelli wrote:
> From: Danesh Petigara <dpetigara@broadcom.com>
> 
> The Broadcom STB SATA host controller does not support device
> initiated power management. Disable support for this feature
> so the driver never sends SETFEATURES commands to the device
> to enable/disable DIPM.
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
