From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 6/7] ata: Add support for the Tegra124 SATA controller
Date: Thu, 26 Jun 2014 14:18:50 +0300
Message-ID: <53AC019A.40404@nvidia.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com> <1403101406-15439-7-git-send-email-mperttunen@nvidia.com> <53A9D31A.6030307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2368 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbaFZLSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jun 2014 07:18:54 -0400
In-Reply-To: <53A9D31A.6030307@wwwdotorg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, "tj@kernel.org" <tj@kernel.org>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

FWIW, from IRC, the series

 > Tested-by: Steev Klimaszewski <steev@gentoo.org>

On 24/06/14 22:35, Stephen Warren wrote:
> On 06/18/2014 08:23 AM, Mikko Perttunen wrote:
>> This adds support for the integrated AHCI-compliant Serial ATA
>> controller present on the NVIDIA Tegra124 system-on-chip.
>
> At a quick glance, this looks fine to me now. I'll wait for an ack to
> take this patch through the Tegra tree, for the reasons I mentioned in
> response to v1.
>
