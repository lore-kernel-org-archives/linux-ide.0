From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Tue, 17 Jun 2014 15:28:29 +0300
Message-ID: <53A0346D.8010005@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-7-git-send-email-mperttunen@nvidia.com> <539F691E.5030204@wwwdotorg.org> <20140617121313.GE18816@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15772 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbaFQM2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 08:28:32 -0400
In-Reply-To: <20140617121313.GE18816@ulmo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: "tj@kernel.org" <tj@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I'll try removing use of all libahci_platform stuff except 
ahci_platform_init_host for v2.

On 17/06/14 15:13, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Mon, Jun 16, 2014 at 04:01:02PM -0600, Stephen Warren wrote:
>> On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
>>> This symbol needs to be exported to power on rails without using
>>> tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
>>> cannot be used in situations where the driver wants to handle clocking
>>> by itself.
>>
>> Thierry, are you OK with this change?
>
> I would've preferred tegra_powergate_sequence_power_up() to be used
> consistently in all drivers. I'm still not convinced that using the
> platform AHCI driver this way is really the best option, since we're
> bending over backwards to fit into what this driver dictates. There
> shouldn't be a need for that.
>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
>
