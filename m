From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v3 2/8] ARM: tegra: Add SATA controller to Tegra124 device
 tree
Date: Mon, 25 Aug 2014 11:23:29 -0600
Message-ID: <53FB7111.2000602@wwwdotorg.org>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com> <1405500863-19696-3-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405500863-19696-3-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 07/16/2014 02:54 AM, Mikko Perttunen wrote:
> This adds the integrated AHCI-compliant Serial ATA controller present
> in Tegra124 systems-on-chip to the Tegra124 device tree.

I have applied patches 2 and 3 to Tegra's for-3.18/dt branch. I fixed 
the DT node sort order when doing so.

I can't apply patch 8 (the defconfig change) until 3.17-rc2 is out, or 
there will be a build failure, but I will do so ASAP.

BTW, once 3.17-rc2 is out, can you please sent a patch to 
multi_v7_defconfig enabling Tegra SATA support there too. Thanks.
