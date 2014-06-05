From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
Date: Thu, 05 Jun 2014 11:29:29 -0600
Message-ID: <5390A8F9.2090408@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> Hi,
> 
> This series adds support for the onboard AHCI-compliant Serial ATA
> controller found on Tegra124 systems-on-chip. The controller is
> enabled on Jetson TK1. The series depends on Peter's efuse series 
> and Thierry's yet to be submitted XUSB pinctrl driver.

This series includes patches to a lot of different subsystems. That will
complicate applying it.

Can you write a summary of the *compile time* dependencies, since that
will influence how the patches get merged.

You mentioned that this series depends on efuse and XUSB padctl. Can you
point out which specific parts of this series depend on which of those
two other series, and whether this is a compile-time or run-time dependency.

I hope that the drivers/ata patches, drivers/clk patches, DT, and
defconfig patches can each be applied to their normal tree and don't
depend on each-other at compile-time at all.

At run-time, obviously all the patches are needed to make the code work,
but since this is a new feature, it's fine if this all only works once
everything is merged together in linux-next or Linus's tree.

Thanks.
