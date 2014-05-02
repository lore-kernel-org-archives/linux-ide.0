From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] ahci: imx: add namespace for register enums
Date: Fri, 2 May 2014 11:42:32 -0400
Message-ID: <20140502154232.GI10204@htj.dyndns.org>
References: <1397803466-28411-1-git-send-email-shawn.guo@freescale.com>
 <1397803466-28411-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1397803466-28411-2-git-send-email-shawn.guo@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Fri, Apr 18, 2014 at 02:44:25PM +0800, Shawn Guo wrote:
> Update register enums a little bit to add proper namespace prefix, and
> have the names match i.MX reference manual.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  drivers/ata/ahci_imx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 497c7ab..009a074 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -29,9 +29,9 @@
>  #include "ahci.h"
>  
>  enum {
> -	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
> -	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
> -	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> +	IMX_SATA_TIMER1MS			= 0x00e0,
> +	IMX_SATA_P0PHYCR			= 0x0178,

P0PHYCR isn't really readily dechipherable to "Port0 PHY Control".
Probably keeping the comment is better?  Also, constant names don't
necessarily have to be exactly the same as hardware manuals.  If
easier to understand and map back (via comment or whatever), using
more humanly-readable names is completely fine.  Also, maybe IMX_SATA_
is a bit too long for prefix?

Thanks.

-- 
tejun
