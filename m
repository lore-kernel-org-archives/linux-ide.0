From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ahci: Changing two module params with static and
 __read_mostly
Date: Tue, 17 Sep 2013 09:24:24 -0700
Message-ID: <1379435064.2012.8.camel@joe-AO722>
References: <1379436518.26153.31.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379436518.26153.31.camel@cliu38-desktop-build>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 2013-09-18 at 00:48 +0800, Chuansheng Liu wrote:
> Here module parameters ahci_em_messages and devslp_idle_timeout can
> be set as static and __read_mostly.
> 
> Signed-off-by: Liu, Chuansheng <chuansheng.liu@intel.com>
> ---
>  drivers/ata/libahci.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
[]
> @@ -189,14 +189,15 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
>  };
>  EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
>  
> -int ahci_em_messages = 1;
> +static int ahci_em_messages __read_mostly = 1;

This one could also be converted to
static bool ahci_em_messages __read_mostly = true;
