From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
Date: Fri, 18 Jul 2014 17:54:04 -0400
Message-ID: <20140718215404.GA1819@htj.dyndns.org>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
 <53C8C9BD.3070709@nvidia.com>
 <53C8F6E6.6020901@redhat.com>
 <20140718150603.GA7196@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140718150603.GA7196@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Jul 18, 2014 at 05:06:04PM +0200, Thierry Reding wrote:
> I think the following patches can go through your tree without causing
> breakage through unresolved dependencies:
> 
> 	[PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
> 	[PATCH v3 6/8] ata: ahci_platform: Increase AHCI_MAX_CLKS to 4
> 	[PATCH v5 7/8] ata: Add support for the Tegra124 SATA controller

Applied to libata/for-3.17 w/ Hans' acks added.  Please check the
following branch and give me a holler if something is amiss.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.17

Thanks.

-- 
tejun
