From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Thu, 9 Mar 2017 20:05:46 +0300
Message-ID: <38ee4af3-b2cf-e9a8-1339-d7d904b7dc15@cogentembedded.com>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170309130216epcas5p276d211cfa5ed9f87b11a73ebe6fcdc7c@epcas5p2.samsung.com>
 <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 03/09/2017 04:01 PM, Bartlomiej Zolnierkiewicz wrote:

> Add Palmchip BK3710 PATA controller driver.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/Kconfig       |   9 ++
>  drivers/ata/Makefile      |   1 +
>  drivers/ata/pata_bk3710.c | 395 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 405 insertions(+)
>  create mode 100644 drivers/ata/pata_bk3710.c
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 7e0fc98..c23ee65 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -509,6 +509,15 @@ config PATA_BF54X
>
>  	  If unsure, say N.
>
> +config PATA_BK3710
> +	tristate "Palmchip BK3710 PATA support"
> +	depends on ARCH_DAVINCI
> +	help
> +	  This option enables support for the integrated IDE controller on
> +	  the TI DaVinci SoC.

    Strictly speaking, Palmchip BK3710 is Mentor Graphics' IDE core, used on 
the original DaVinci's. Mentor's documentation was never publicly available 
though...

[...]

MBR, Sergei
