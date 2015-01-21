From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: next-20150120 broken on Tegra by "ata: libahci: Allow using
 multiple regulators"
Date: Wed, 21 Jan 2015 11:25:23 -0500
Message-ID: <20150121162523.GE8684@htj.dyndns.org>
References: <alpine.DEB.2.02.1501210003010.5450@utopia.booyaka.com>
 <20150121105001.GA9921@ulmo.nvidia.com>
 <20150121123134.GD8684@htj.dyndns.org>
 <20150121155519.GA25166@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150121155519.GA25166-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jan 21, 2015 at 04:55:21PM +0100, Thierry Reding wrote:
> From a4f78e3ec05f1b2ad86aa44d6bd5394d75a23a06 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Wed, 21 Jan 2015 11:50:52 +0100
> Subject: [PATCH] ata: libahci: Fix devres cleanup on failure
> 
> Commit c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
> releases regulators during ahci_platform_put_resources(). That doesn't
> work because the function is run as part of the devres machinery. Such
> resources are torn down in reverse order. Since the array that holds
> pointers to the regulators is allocated using devres after the device
> context to which ahci_platform_put_resources() is attached, the memory
> will be freed before calling ahci_platform_put_resources() and thereby
> causing a use-after-free error.
> 
> This commit fixes this by using regular allocations for the array. The
> memory can then be freed after the regulators have been released. This
> conserves the advantages of using the managed API.
> 
> Reported-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Applied to libata/for-3.20.

Thanks.

-- 
tejun
