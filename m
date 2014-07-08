From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 6/7] ata: Add support for the Tegra124 SATA controller
Date: Tue, 8 Jul 2014 11:20:25 +0300
Message-ID: <53BBA9C9.8020306@nvidia.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com> <1403101406-15439-7-git-send-email-mperttunen@nvidia.com> <53A9D31A.6030307@wwwdotorg.org> <53AC019A.40404@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53AC019A.40404@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, "tj@kernel.org" <tj@kernel.org>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hey Tejun,

the prerequisites for this series have now been acked and it would be 
nice to have it for 3.17. Could you take a look at it?

Thanks,
Mikko

On 26/06/14 14:18, Mikko Perttunen wrote:
> FWIW, from IRC, the series
>
>   > Tested-by: Steev Klimaszewski <steev@gentoo.org>
>
> On 24/06/14 22:35, Stephen Warren wrote:
>> On 06/18/2014 08:23 AM, Mikko Perttunen wrote:
>>> This adds support for the integrated AHCI-compliant Serial ATA
>>> controller present on the NVIDIA Tegra124 system-on-chip.
>>
>> At a quick glance, this looks fine to me now. I'll wait for an ack to
>> take this patch through the Tegra tree, for the reasons I mentioned in
>> response to v1.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
