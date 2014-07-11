From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/2] phy: qcom: Add driver for QCOM APQ8064 SATA PHY
Date: Fri, 11 Jul 2014 16:33:38 +0200
Message-ID: <2632799.IFO1aEjqtg@amdc1032>
References: <1404903807-26032-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1828880.cILxhDlkNH@amdc1032> <53BFE8F9.7050700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <53BFE8F9.7050700@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday, July 11, 2014 02:39:05 PM Srinivas Kandagatla wrote:
> Thankyou for the comments,
> 
> On 11/07/14 13:38, Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi,
> >
> > On Wednesday, July 09, 2014 12:04:06 PM Srinivas Kandagatla wrote:
> >> Add a PHY driver for uses with AHCI based SATA controller driver on the
> >> APQ8064 family of SoCs.
> >>
> >> This patch is a forward port from Qualcomm's v3.4 andriod kernel.
> >
> > Android?
> yep.
> >
> > unused define, please remove it
> >
> Will fix these instances in next version.
> >> +
> >> +#define UNIPHY_PLL_LOCK		BIT(0)
> >> +#define SATA_PHY_TX_CAL		BIT(0)
> >> +#define SATA_PHY_RX_CAL		BIT(0)
> >> +
> >> +/* default timeout set to 1 sec */
> >> +#define TIMEOUT_MS		10000
> >> +
> >> +struct qcom_apq8064_sata_phy {
> >> +	void __iomem *mmio;
> >> +	struct clk *cfg_clk;
> >> +	struct device *dev;
> >> +};
> >> +
> >> +/* Helper function to do poll and timeout */
> >> +static int read_poll_timeout(void __iomem *addr, u32 mask)
> >> +{
> >> +	unsigned long timeout = jiffies + msecs_to_jiffies(TIMEOUT_MS);
> >> +	u32 val;
> >> +
> >> +	do {
> >> +		cpu_relax();
> >> +		val = readl_relaxed(addr);
> >> +		if (val & mask)
> >> +			break;
> >> +	} while (!time_after(jiffies, timeout));
> >
> > It would be better to use usleep_[range]() (or even msleep() if needed)
> > instead of just using cpu_relax().
> 
> We really want to poll the register here, usleep/msleep would be useful 
> if we know already know how much delay is required, but in this case the 
> its not true.

I don't mean replacing the whole function, you can still do polling with
i.e. doing usleep_range(1000, 2000) with 1000 retries.  The advantage of
doing it this way would be that processor could do some useful work or
sleep during wait time instead of just busy waiting.

One example of many how to do it:

drivers/i2c/busses/i2c-s3c2410.c:

static bool is_ack(struct s3c24xx_i2c *i2c)
{
        int tries;

        for (tries = 50; tries; --tries) {
                if (readl(i2c->regs + S3C2410_IICCON)
                        & S3C2410_IICCON_IRQPEND) {
                        if (!(readl(i2c->regs + S3C2410_IICSTAT)
                                & S3C2410_IICSTAT_LASTBIT))
                                return true;
                }
                usleep_range(1000, 2000);
        }
        dev_err(i2c->dev, "ack was not recieved\n");
        return false;
}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
