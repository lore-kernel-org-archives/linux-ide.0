From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/3] pwm: iproc: Add support for Broadcom iproc pwm
 controller
Date: Wed, 22 Jun 2016 10:31:26 -0700
Message-ID: <20160622173126.GA74558@google.com>
References: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
 <1466594987-26537-3-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466594987-26537-3-git-send-email-yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jun 22, 2016 at 07:29:46AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> Add support for the PWM controller present in Broadcom's iProc
> family of SoCs. This driver is derived from the pwm-bcm-kona
> driver, with changes to the register offsets and bit positions.
> It has been tested on the  Northstar+ bcm958625HR board.
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pwm/Kconfig         |  10 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-bcm-iproc.c | 327 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c
> 
[...]
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> new file mode 100644
> index 0000000..952c457
> --- /dev/null
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -0,0 +1,327 @@
[...]
> +static const struct pwm_ops iproc_pwm_ops = {
> +	.config = iproc_pwmc_config_check,
> +	.set_polarity = iproc_pwmc_set_polarity,
> +	.enable = iproc_pwmc_enable,
> +	.disable = iproc_pwmc_disable,
> +	.owner = THIS_MODULE,
> +};

Have you considered trying the new apply() callback instead of
config()/set_polarity()/enable()/disable()?

[...]

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
