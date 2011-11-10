From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Thu, 10 Nov 2011 15:34:30 -0500
Message-ID: <4EBC3556.5000000@garzik.org>
References: <20111110151852.GA7465@oksana.dev.rtsoft.ru> <20111110152606.GB3207@oksana.dev.rtsoft.ru> <20111110153816.239af1d7@lxorguk.ukuu.org.uk> <20111110162859.GA7088@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
Sender: linux-next-owner@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

On 11/10/2011 11:28 AM, Anton Vorontsov wrote:
> Drivers should not use NO_IRQ; moreover, some architectures don't
> have it nowadays. '0' is the 'no irq' case.
>
> Signed-off-by: Anton Vorontsov<cbouatmailru@gmail.com>
> Acked-by: Alan Cox<alan@linux.intel.com>
> ---
>
> On Thu, Nov 10, 2011 at 03:38:16PM +0000, Alan Cox wrote:
>> On Thu, 10 Nov 2011 19:26:06 +0400
>> Anton Vorontsov<cbouatmailru@gmail.com>  wrote:
>>
>>> Drivers should not use NO_IRQ; moreover, some architectures don't
>>> have it nowadays. '0' is the 'no irq' case.
>>>
>>> Signed-off-by: Anton Vorontsov<cbouatmailru@gmail.com>
>>
>> Acked-by: Alan Cox<alan@linux.intel.com>
>
> In case if we don't want a "band-aid fix" for 3.2, here is the patch
> that just does the proper fix (w/ a risk to break minor architectures).
>
>   drivers/ata/pata_of_platform.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index a72ab0d..2a472c5 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
>   	}
>
>   	ret = of_irq_to_resource(dn, 0,&irq_res);
> -	if (ret == NO_IRQ)
> +	if (!ret)
>   		irq_res.start = irq_res.end = 0;
>   	else
>   		irq_res.flags = 0;

Unless someone screams, that is what I'll push upstream.

	Jeff
