From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 0/3] pwm support for Broadcom iProc SoC's
Date: Wed, 22 Jun 2016 10:06:26 -0700
Message-ID: <576AC592.7030805@broadcom.com>
References: <1466594987-26537-1-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466594987-26537-1-git-send-email-yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Dhanajaya,

Patch series looks good.

Acked-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

On 16-06-22 04:29 AM, Yendapally Reddy Dhananjaya Reddy wrote:
> This patchset contains the pwm support for the Broadcom's iProc SoC's.
>
> The first patch provides the documentation details and the
> second patch contains the controller support details. The third patch
> contains the enable method for Northstar Plus SoC.
>
> This patch series has been tested on NSP bcm958625HR board.
> The pwm is not enabled for this board as the pins are open and not used.
>
> This patch series is based on v4.7.0-rc1 and is available from github
> repo: https://github.com/Broadcom/cygnus-linux.git
> branch: iproc-pwm-v4
>
>
> Changes since v3
> Addressed comments from Scott to include COMPILE_TEST
>
> Changes since v2
> Rebased on v4.7.0-rc1
>
> Changes since v1
> Addressed the review comments from Thierry
>   1. Use separate driver for iProc SoC's.
>   2. Added Robs ack to the Documentation patch
>
> Yendapally Reddy Dhananjaya Reddy (3):
>    Documentation: dt: Add Broadcom iproc pwm controller binding
>    pwm: iproc: Add support for Broadcom iproc pwm controller
>    ARM: dts: NSP: Add PWM Support to DT
>
>   .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 ++
>   arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
>   drivers/pwm/Kconfig                                |  10 +
>   drivers/pwm/Makefile                               |   1 +
>   drivers/pwm/pwm-bcm-iproc.c                        | 327 +++++++++++++++++++++
>   5 files changed, 367 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
>   create mode 100644 drivers/pwm/pwm-bcm-iproc.c
>

Regards,
Scott
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
