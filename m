From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Tue, 17 Jun 2014 12:14:47 -0400
Message-ID: <20140617161447.GH31819@htj.dyndns.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
 <1470404.13mIFv0Hnj@amdc1032>
 <53A0686F.4000303@wwwdotorg.org>
 <20140617161320.GG31819@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140617161320.GG31819-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jun 17, 2014 at 12:13:20PM -0400, Tejun Heo wrote:
> On Tue, Jun 17, 2014 at 10:10:23AM -0600, Stephen Warren wrote:
> > > sata_writel() and sata_read() static inlines don't seem to add any value.
> > > 
> > > Can they be removed?
> > 
> > Such functions are quite idiomatic in drivers, and serve to simplify all
> > the call-sites by removing the need to write out the addition of the
> > base address everywhere.
> 
> I think it obfuscates more than helps.  If you absoluately have to
> keep it, please at least name it so that it's clear that it's
> something specific to this driver.

Please also drop inline.  It isn't a difficult optimization to perform
for the compiler.

-- 
tejun
