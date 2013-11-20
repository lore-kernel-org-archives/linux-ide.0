From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RESEND PATCH 1/6] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Wed, 20 Nov 2013 20:51:55 +0800
Message-ID: <20131120125154.GD22308@S2101-09.ap.freescale.net>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
 <1384943242-8201-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1384943242-8201-1-git-send-email-marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Cc: Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Eric Nelson <eric.nelson@boundarydevices.com>, linux-arm-kernel@lists.infradead.org, Linux-IDE <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 20, 2013 at 11:27:22AM +0100, Marek Vasut wrote:
> We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> Linux will fail to find the attached drive on some boards.
> 
> This entire fix was:
> Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  drivers/ata/ahci_imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> RESEND: Fix the Cc here.
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index ae2d73f..478921b 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -125,6 +125,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
>  			| IMX6Q_GPR13_SATA_TX_LVL_MASK
>  			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
> +			| IMX6Q_GPR13_SATA_MPLL_CLK_EN

So shouldn't number 0x07fffffd in the comment right above the code be
updated to 0x07fffffe?

Shawn

>  			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
>  			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
>  			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F
> -- 
> 1.8.4.2
> 
