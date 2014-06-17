From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Tue, 17 Jun 2014 10:10:23 -0600
Message-ID: <53A0686F.4000303@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-9-git-send-email-mperttunen@nvidia.com> <1470404.13mIFv0Hnj@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470404.13mIFv0Hnj@amdc1032>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/17/2014 06:14 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, June 04, 2014 02:32:38 PM Mikko Perttunen wrote:
>> This adds support for the integrated AHCI-compliant Serial ATA
>> controller present on the NVIDIA Tegra124 system-on-chip.

>> +static inline void sata_writel(struct tegra_ahci_priv *tegra, u32 value,
>> +				 unsigned long offset)
>> +{
>> +	writel(value, tegra->sata_regs + offset);
>> +}
>> +
>> +static inline u32 sata_readl(struct tegra_ahci_priv *tegra,
>> +				unsigned long offset)
>> +{
>> +	return readl(tegra->sata_regs + offset);
>> +}
> 
> sata_writel() and sata_read() static inlines don't seem to add any value.
> 
> Can they be removed?

Such functions are quite idiomatic in drivers, and serve to simplify all
the call-sites by removing the need to write out the addition of the
base address everywhere.

>> +static struct platform_driver tegra_ahci_driver = {
>> +	.probe = tegra_ahci_probe,
>> +	.remove = ata_platform_remove_one,
>> +	.driver = {
>> +		.name = "tegra-ahci",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = tegra_ahci_of_match,
>> +	},
> 
> This driver lacks PM suspend/resume support.  I assume that
> the Tegra124 platform also doesn't support suspend/resume yet
> (if so a comment in the driver code about this would be useful),
> otherwise the driver should be fixed.

We do have basic system suspend/resume support. However, I don't think
missing suspend/resume in an individual driver should stop it from being
merged. It can certainly be added later.
