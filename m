From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 7/9] ahci: Increase AHCI_MAX_CLKS to 4
Date: Mon, 16 Jun 2014 16:04:26 -0600
Message-ID: <539F69EA.6000200@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-8-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401881559-18469-8-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> The Tegra AHCI device requires four clocks, so increase the maximum
> amount of handled clocks from three to four.

Tejun,

The SATA driver in patch 8/9 in this series would usually be applied in
your ATA tree. However, it has a lot of compile-time dependencies on
things outside the ATA tree that I expect you don't want to deal with.

If you're OK with patches 7 and 8, could you ack them so that I can
apply them to the Tegra tree?

I assume the patches won't cause any significant conflicts, but if you
need, I can certainly give you a signed tag back to allow you to merge
the driver patch (plus the compile-time dependencies) into your tree
later if needed.
