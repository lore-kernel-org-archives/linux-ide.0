From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH][v2] sata_fsl: Add asynchronous notification support
Date: Wed, 01 Jul 2009 12:25:51 +0400
Message-ID: <4A4B1D8F.9090609@ru.mvista.com>
References: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: ashish kalra <ashish.kalra@freescale.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

Hello.

ashish kalra wrote:

> Enable device hot-plug support on Port multiplier fan-out ports
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
[...]
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 94eaa43..5751145 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -34,7 +34,7 @@ enum {
>
>      SATA_FSL_HOST_FLAGS    = (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -                ATA_FLAG_PMP | ATA_FLAG_NCQ),
> +                 ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),

   Why are you breaking the alignment? There's alos trailing whitespace 
here...

> @@ -132,7 +132,7 @@ enum {
>      INT_ON_SINGL_DEVICE_ERR = (1 << 1),
>      INT_ON_CMD_COMPLETE = 1,
>
> -    INT_ON_ERROR = INT_ON_FATAL_ERR |
> +    INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |

   Trailing whitespace.

> @@ -154,6 +154,7 @@ enum {
>
>      DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG |
>          IE_ON_SIGNATURE_UPDATE |
> +        IE_ON_SNOTIFY_UPDATE |

   Again.

>          IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
>
>      EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
> @@ -1003,6 +1004,11 @@ static void sata_fsl_error_intr(struct ata_port 
> *ap)
>          freeze = 1;
>      }
>
> +    /* Handle SDB FIS receive & notify update */
> +    if (hstatus & INT_ON_SNOTIFY_UPDATE) {
> +        sata_async_notification(ap);
> +    }

   And again -- on every line.

MBR, Sergei
