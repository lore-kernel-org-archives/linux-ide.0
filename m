From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Thu, 5 Jun 2014 15:59:15 +0300
Message-ID: <539069A3.9010100@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>	<1401881559-18469-9-git-send-email-mperttunen@nvidia.com> <CAL_JsqLh7kqnufNaWKdOEFb=m2mViFX4kTGMHOKmHuTAVMr+fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11337 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaFEM7T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jun 2014 08:59:19 -0400
In-Reply-To: <CAL_JsqLh7kqnufNaWKdOEFb=m2mViFX4kTGMHOKmHuTAVMr+fA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Tejun Heo <tj@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Thanks, will remove.

- Mikko

On 05/06/14 15:18, Rob Herring wrote:
> On Wed, Jun 4, 2014 at 6:32 AM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> This adds support for the integrated AHCI-compliant Serial ATA
>> controller present on the NVIDIA Tegra124 system-on-chip.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>
> [...]
>
>> +static int tegra_ahci_probe(struct platform_device *pdev)
>> +{
>> +       const struct of_device_id *match;
>> +       struct ahci_host_priv *hpriv;
>> +       struct tegra_ahci_priv *tegra;
>> +       int ret;
>> +
>> +       match = of_match_device(tegra_ahci_of_match, &pdev->dev);
>
> This is not needed.
>
>> +       if (!match)
>> +               return -EINVAL;
>> +
