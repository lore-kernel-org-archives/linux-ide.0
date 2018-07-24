From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
Date: Tue, 24 Jul 2018 16:22:59 +0100
Message-ID: <197120a6-4c75-14ca-5d46-0e6cfbbb1ebd@nvidia.com>
References: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
 <c8a963fa-70c8-ea79-3c30-69bf723fb764@nvidia.com>
 <1531895430.16896.2.camel@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531895430.16896.2.camel@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "mperttunen@nvidia.com" <mperttunen@nvidia.com>, "clabbe@baylibre.com" <clabbe@baylibre.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


On 18/07/18 07:30, Marcel Ziswiler wrote:
> On Tue, 2018-07-17 at 13:57 +0300, Mikko Perttunen wrote:
>> Thanks!
> 
> Yes, that fixes Apalis TK1 crashing as of late as well.
> 
>> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Can someone pick this up? Without this some Tegra boards cannot boot.

Thanks!
Jon

-- 
nvpublic
