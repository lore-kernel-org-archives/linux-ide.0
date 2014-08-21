From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] ata: ahci: tegra: fix build error
Date: Thu, 21 Aug 2014 13:17:14 -0600
Message-ID: <53F645BA.4000402@wwwdotorg.org>
References: <20140821190824.GM11146@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140821190824.GM11146-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On 08/21/2014 01:08 PM, Felipe Balbi wrote:
> Currently, ahci_tegra doesn't build because it includes a file that
> doesn't exist.
>
> The problem is that first commit 306a7f9 (ARM: tegra: Move includes to
> include/soc/tegra) renamed include/linux/tegra-powergate.h to
> include/soc/tegra/powergate.h.
>
> Later commit 7232398 (ARM: tegra: Convert PMC to a driver) renamed
> include/soc/tegra/powergate.h to include/soc/tegra/pmc.h and neither
> commits fixed drivers/ata/ahci_tegra.c.
>
> Fix that so the driver has a chance of building. With current kernels.
>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.16

This driver first appeared in v3.17-rc1.

This patch has already been sent, and apparently applied:

https://lkml.org/lkml/2014/8/16/36

I wonder if libata/for-3.17-fixes isn't in linux-next?
