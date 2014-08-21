From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ahci_tegra build failure in Linus' tree
Date: Thu, 21 Aug 2014 14:32:37 -0500
Message-ID: <20140821193237.GB6168@mtj.dyndns.org>
References: <E1XKRXZ-0000vL-4b@cassiel.sirena.org.uk>
 <20140821185352.GP24407@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140821185352.GP24407-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Aug 21, 2014 at 01:53:52PM -0500, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 01:32:29PM +0100, Build bot for Mark Brown wrote:
> 
> > ../drivers/ata/ahci_tegra.c:27:35: fatal error: linux/tegra-powergate.h: No such file or directory
> 
> ARM allmodconfig currently fails to build in mainline due to the above
> error.  It has been fixed in -next by Mikko Perttunen in commit
> 0e5740770f34381b (ata: ahci_tegra: Change include to fix compilation)
> but it's not clear to me if that's on it's way to Linus - it'd be great
> if it could be.

Will push it out right away.

Thanks.

-- 
tejun
