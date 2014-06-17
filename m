From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Tue, 17 Jun 2014 20:36:36 +0300
Message-ID: <53A07CA4.7080206@kapsi.fi>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1470404.13mIFv0Hnj@amdc1032> <53A0686F.4000303@wwwdotorg.org> <6652229.bPNq3Yp8If@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:43745 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933325AbaFQRgw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jun 2014 13:36:52 -0400
In-Reply-To: <6652229.bPNq3Yp8If@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org, pdeschrijver@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org

On 06/17/2014 08:04 PM, Bartlomiej Zolnierkiewicz wrote:
>
> Hi,
>
> On Tuesday, June 17, 2014 10:10:23 AM Stephen Warren wrote:
>> On 06/17/2014 06:14 AM, Bartlomiej Zolnierkiewicz wrote:
>
> [...]
>
>>>> +static struct platform_driver tegra_ahci_driver = {
>>>> +	.probe = tegra_ahci_probe,
>>>> +	.remove = ata_platform_remove_one,
>>>> +	.driver = {
>>>> +		.name = "tegra-ahci",
>>>> +		.owner = THIS_MODULE,
>>>> +		.of_match_table = tegra_ahci_of_match,
>>>> +	},
>>>
>>> This driver lacks PM suspend/resume support.  I assume that
>>> the Tegra124 platform also doesn't support suspend/resume yet
>>> (if so a comment in the driver code about this would be useful),
>>> otherwise the driver should be fixed.
>>
>> We do have basic system suspend/resume support. However, I don't think
>> missing suspend/resume in an individual driver should stop it from being
>> merged. It can certainly be added later.
>
> There should be at least FIXME in the driver explaining the situation and
> I would really prefer to have PM support added when the driver is still
> "hot" (meaning there are people actively working on it) instead of possibly
> having to chase people months/years later when they have already moved on
> and are working on something else.  Please also note that adding PM support
> should be quite simple if the driver is designed correctly.
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

AFAIK, the deepest level of suspend currently supported on upstream is 
LP1, for which the driver doesn't need to do anything. Only when we go 
to LP0 the driver will need to save/reload registers and stuff.
