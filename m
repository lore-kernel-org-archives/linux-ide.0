From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 00/10] ARM: da850-lcdk: add SATA support
Date: Tue, 17 Jan 2017 13:34:24 +0100
Message-ID: <CAMpxmJVdFhzLGmY8maUo8k1Gzgwp+2ivFD8VqG3SbspFoXNvbw@mail.gmail.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

2017-01-13 13:37 GMT+01:00 Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>:
> This series contains all the changes necessary to make SATA work on
> the da850-lcdk board.
>
> The first patch adds a clock lookup entry required for the ahci core
> to retrieve a functional clock.
>
> The second enables relevant config options for all davinci boards.
>
> The third adds device tree bindings for the ahci_da850 driver.
>
> The fourth adds a workaround for a SATA controller instability we
> detected after increasing the PLL0 frequency for proper LCD
> controller support.
>
> Patches 5 through 7 extend the ahci_da850 driver - add DT support,
> un-hardcode the clock multiplier value and add a workaround for
> a quirk present on the da850 SATA controller.
>
> Patches 8-10 add the device tree changes required to probe the driver.
>
> I'm posting the series as a whole to give all reviewers the full
> picture and visibility of the changes required, if needed I can resend
> the patches separately.
>

Superseded by v2.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
