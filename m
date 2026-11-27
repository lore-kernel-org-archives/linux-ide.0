Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803415;
	b=A3fYj2DqPov1i+5eB4WGUiJXOnh8bc8JWqpZ0r+DgsCtbZ0mLQFDt74RPdofXGmtr0QC
	 QMgGMTLwur5YG721P9+sp520TZlLuHOO5/xigf3+N4ItMg5esyQS3qkwo4X9kNIK/8V0a
	 jlDKfopEZaIl5bm3NyI+eyOQ7EQDRbeE1w0MNJ6frsYbfAimIbZ9kxXrTSp/Q5C5X9xHq
	 lLX1Vi6ZgUNPWPnJWk2sW02IidllxmJMrQwEHQaWWFg9FsUXlFnT253nU4xnz0pNzc1zp
	 csu7TBS0tnomg1eihKpTxH0kj3oWEOWbi5TnBrSir3Qjo/9YQW6xEhFkzVxtZ5d3neQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803415;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IRquHP6+JpDcME/70XQJzwgPUGu0D6NcBC9+C049/lA=;
	b=VeT3rgIbo5gZMtI+onSUDrUwXrhQJdqM8N0dEkSPJPUOJUuuDQduyGcDCkx9IVAy2DFw
	 fp2+3n047rZjgYxJxotmTwpMxHeVdQGHujpx30NUHWNaji8cKM/xT1EZA+5YJSdUywLeC
	 Ej/he5XjlptvpaWRACnzYlsalMCFaaOAlSuHpqFdMXSJRqI7UStpbfM+kB+m6QnUaPFTj
	 LbDOhGlHPu4fOCCWO7jCgKM/u0zTB1+kl4Ep0Mnq9BkYIDD7aXnyRV/YFpGCcQAGd3H0U
	 ocVmKkPRpMdcpglhXu4dUFMtHK2mIjrxhHCVfKOJRSNU4efZGHNkaw9cmPxyVSDKq8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Cyrj0nr+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF6606A324;
	Fri, 27 Nov 2026 18:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3DF6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Cyrj0nr+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 699331575;
	Fri, 27 Nov 2026 10:16:51 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC783F86C;
	Fri, 27 Nov 2026 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795803414; bh=6imln1W2Yy1aPN/smnTpJTPts3LNPdp2Py2G8tyPdSw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Cyrj0nr+Aawpo4a9zscl6bwOk0Ckq97a90PJDU6Zc5xrVZ/I3+WGA1BXAgrX+o+iB
	 9D8+slEkc9p2uO0X7wiZF90OZfeY5xl+tPiJX6++jX9vm1PUww2Ws4dWeR+33FPyfQ
	 RC1U0HfsJvGpo10Uyw8MvP8t+ubp08BZ5OSdJgEA=
Message-ID: <03b2548c-e451-408e-b5df-a5dec8c290f8@arm.com>
Date: Fri, 27 Nov 2026 18:16:48 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/9] soc: rockchip: grf: Assign the StreamIDs of the
 RK3588 PHP SMMU masters
To: aiyengar1990@gmail.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, Shawn Lin <shawn.lin@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
 <20261113-mmu600-php-v1-4-231196049a3b@gmail.com>
Content-Language: en-GB
In-Reply-To: <20261113-mmu600-php-v1-4-231196049a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2026 4:38 pm, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> The StreamIDs of the six masters behind the RK3588 PHP SMMU come from
> PHP GRF registers that reset to 0 and are never programmed, so the SMMU
> can not tell the masters apart.
> 
> Assign StreamIDs 1-6 on both AXI channels. 0 stays unused, so a master
> that loses its ID is aborted instead of using another device's tables.

Urgh... could you at least hide this in U-Boot and have that inject the 
corresponding "iommus" entries into the DTB it's passing, similar to 
what the NXP Layerscape platforms do for their "iommu-map" generation?

StreamIDs are really not meant to be programmable, and even if they are 
then that is not supposed to be exposed to OSes. The Arm Base System 
Architecture[1] explicitly calls this out:

   R_ITS_DEV_9: The relationships between a device, its StreamID and
   its DeviceID are considered static by OS or hypervisor software. If
   the mapping is not fixed by hardware, the relationship between a
   StreamID and a DeviceID must not change after system initialization,
   and OS drivers must not be required to set it up.

Even just in practical terms, how is this going to work if someone boots 
a new kernel with an older DT or vice-versa, and one set of hard-coded 
values then fails to correspond to the other?

Thanks,
Robin.

[1] https://support.arm.com/documentation/den0094/latest/

> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   drivers/soc/rockchip/grf.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
> index b459607c118a..3f0f82a2119f 100644
> --- a/drivers/soc/rockchip/grf.c
> +++ b/drivers/soc/rockchip/grf.c
> @@ -168,6 +168,40 @@ static const struct rockchip_grf_info rk3588_sysgrf __initconst = {
>   	.num_values = ARRAY_SIZE(rk3588_defaults),
>   };
>   
> +/* PHP SMMU StreamIDs: bits 15:0, no write-enable mask */
> +#define RK3588_PHP_GRF_GMAC0_SID_AW	0x0074
> +#define RK3588_PHP_GRF_GMAC1_SID_AW	0x007c
> +#define RK3588_PHP_GRF_SATA0_SID_AW	0x0084
> +#define RK3588_PHP_GRF_SATA1_SID_AW	0x008c
> +#define RK3588_PHP_GRF_SATA2_SID_AW	0x0094
> +#define RK3588_PHP_GRF_GMAC0_SID_AR	0x009c
> +#define RK3588_PHP_GRF_GMAC1_SID_AR	0x00a4
> +#define RK3588_PHP_GRF_SATA0_SID_AR	0x00ac
> +#define RK3588_PHP_GRF_SATA1_SID_AR	0x00b4
> +#define RK3588_PHP_GRF_SATA2_SID_AR	0x00bc
> +#define RK3588_PHP_GRF_USB3OTG2_SID_AR	0x00c4
> +#define RK3588_PHP_GRF_USB3OTG2_SID_AW	0x00cc
> +
> +static const struct rockchip_grf_value rk3588_defaults_php_grf[] __initconst = {
> +	{ "gmac0 write streamid", RK3588_PHP_GRF_GMAC0_SID_AW, 1 },
> +	{ "gmac0 read streamid", RK3588_PHP_GRF_GMAC0_SID_AR, 1 },
> +	{ "gmac1 write streamid", RK3588_PHP_GRF_GMAC1_SID_AW, 2 },
> +	{ "gmac1 read streamid", RK3588_PHP_GRF_GMAC1_SID_AR, 2 },
> +	{ "sata0 write streamid", RK3588_PHP_GRF_SATA0_SID_AW, 3 },
> +	{ "sata0 read streamid", RK3588_PHP_GRF_SATA0_SID_AR, 3 },
> +	{ "sata1 write streamid", RK3588_PHP_GRF_SATA1_SID_AW, 4 },
> +	{ "sata1 read streamid", RK3588_PHP_GRF_SATA1_SID_AR, 4 },
> +	{ "sata2 write streamid", RK3588_PHP_GRF_SATA2_SID_AW, 5 },
> +	{ "sata2 read streamid", RK3588_PHP_GRF_SATA2_SID_AR, 5 },
> +	{ "usb3otg2 write streamid", RK3588_PHP_GRF_USB3OTG2_SID_AW, 6 },
> +	{ "usb3otg2 read streamid", RK3588_PHP_GRF_USB3OTG2_SID_AR, 6 },
> +};
> +
> +static const struct rockchip_grf_info rk3588_phpgrf __initconst = {
> +	.values = rk3588_defaults_php_grf,
> +	.num_values = ARRAY_SIZE(rk3588_defaults_php_grf),
> +};
> +
>   static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
>   	{
>   		.compatible = "rockchip,rk3036-grf",
> @@ -202,6 +236,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
>   	}, {
>   		.compatible = "rockchip,rk3576-ioc-grf",
>   		.data = (void *)&rk3576_iocgrf,
> +	}, {
> +		.compatible = "rockchip,rk3588-php-grf",
> +		.data = (void *)&rk3588_phpgrf,
>   	}, {
>   		.compatible = "rockchip,rk3588-sys-grf",
>   		.data = (void *)&rk3588_sysgrf,
> 

