Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870563;
	b=RmN3Y82uvhQCQ4O7zFSwGwh3DvifaIAZXCZDvopPhaTnTMKPiIzSOPrLjLzvNceeSJmf
	 NTbSo6X7+qqD1USChDzs3N82t/jphK4UPhyNaDRRESuMNjwf6tjGiLqGxGUaVEgRI4HqM
	 jswujdpJvfrQNOWCMXsn0j5Yt+wVJ3fchLoWI2fWxmEORn9FTs4zzitxOpp1s6WBBGMz8
	 g14RC5HFf8P2jXjoF26YrHIeMUH2Dmf914Ak3+N3K0mNsnvPevgyJDyENXYuhXx1VL1KE
	 0DI4+41ZZwsLZDgXEtk0MvCD3Lwljqj8qW30hB7uJKs4x8J9DD5ib+k/59DGKa+XRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870563;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=7JGRKYIhmwCYE3KPUYPJEdw6GaPbg8hbt4OXk4UERBc=;
	b=0c2twGsuzwPoOk0vK4a30EpfXvr2w5whIzyUpidG9kmIisxcaa7RjUqIrXjXvXK+oxTj
	 jecHxrE7itsKsC19gaPYzax1W7JU2L0YLGkytKaiYoc9RpVFQjY8P+4HCzY7AfXAJ9gx4
	 XidEVgUu56Sk67D37NC1pqGN2hIlcLB1o/UqXQ/LofCxJSpqTNpkLb1TvBl8ajyPfP6hv
	 MXRajBQQAVbJ4tnsneY98tXyTEX4zBfcY/EqhUhsMi6t4ySqlgKprhrIYLojAYeyAbJgh
	 me8kCTkuz7TD907b7L8KBkS4mHdwI4MgJtG54Tnn0oZE9pIva3nMHuR1PvNSYQRUaSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=W8iiICVZ;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64454606A33B
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 23:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64454606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=W8iiICVZ
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-949680e6d82so211940885a.2
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870562; x=1795475362;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7JGRKYIhmwCYE3KPUYPJEdw6GaPbg8hbt4OXk4UERBc=;
        b=AGgQQ4ulcaVaEv4lCQbLxysSqsCFlBJ8ptQB6ntsJBoFgvt361EenmRemG7YVI7iLD
         87LhSfZTE8PyBBDDpLuZjbhD1TyTqe44mmjsDSSVUdL4/QUE2+SgB7uYiZUtP21wXeyu
         HfYKrp+wTOwQcdyEOmrOiKYxBieGWYx2j+05S/THtRCSaZ5xsIGdUI8TUGcKtwVWJJ8J
         og8lNW3F5OwTQxzX63BEUPa7e3ckACAB+0pDFhWbm3M9q+0FEm/SdhHuFfOOm0nj10X7
         JZ7U1juzq3Nh6NLpjCrtPoIitsJiY3ROBCKarnFTI0xF6yo5rOJcJPkvCO8Qm4RaTMkd
         e9qg==
X-Forwarded-Encrypted: i=1; AL+hErGKDnGc9F6w0NFE49YEfhgegwI1HjrrDIkNsXjss4e98K3jzru9qmMl8SS7eM9/KbSqAL8ojr6vnVg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rIN/LNiPeAmfZN/03vbVo2SRqsthuzt3YJeAGwt6lsHVL4gVC
	GGwdtaMBB3BCvtZrtYa4b0a/f2KzVneXF4apewpdKpnuZJQTjx+mfhnPKEu2GbZnWJ0Gz7aowNa
	5ncV5J1rvJa8bBZiLn9hIoE+mbiiThK5lOyPdLy/rz1EZVU2/SpyIbGBSoiPlG0Q0PAgQV3M5el
	VY1lqCiUZbUuBjU/JBEHjhAnPA73gnukaJyaPdU2u+I4RrvpXPvgBYiYFrErrlNUHtAD+KlkChe
	puhm5QXhyLy1vNCn3PT
X-Gm-Gg: AYBFou2MNegEYWXvRW+kG3hgBAE3yso1wk8KPtrS7q0GOWAaVZneTX1YgyeVt1W6uTx
	7vW3+6W5dmU6VdUUKMNfQvWaSK1d4B4BKoTVg4hBCYay+Y3fh90zk43FwhZxd2WuV2JtZbDPL9B
	/k5prYBpcs2YJ0t6NX0AB+JhJJ8HtMy3qb1lGrnOUesM2iHvOuldYhpJuAwOzP0gA0t1rnzFyJg
	FbG5AIdu3pSln0jk94vYJ/eQ1pzNR+NQU39Jv/p0H5xgorz4jHezFs8zH2UzXAw/pLO5b9CpChZ
	vECkpdhMb9bwQYIN1Zqcp+h6Ff+458RI0uur+7N7jYxW7E9HshW1QfaPoNxnMYcSo+vlKdUIQcK
	w3aTEYSPz1c81y72/+hPF9XBfsIRzFNaOz6UwhXzr0/PfeOchcdziL3GDg9mC+3VJgMNvHVVFSB
	pMAPj0VEneI17Ni8KO5tXkqCYFND0xeSXvgJ71HLkp
X-Received: by 2002:a05:620a:2715:b0:939:a0f3:6aef with SMTP id af79cd13be357-9494ba7cfbcmr1880327685a.23.1794870562349;
        Mon, 16 Nov 2026 15:09:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9494c7d2babsm120410585a.16.2026.11.16.15.09.22
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:09:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so5858718c88.0
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794870561; x=1795475361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JGRKYIhmwCYE3KPUYPJEdw6GaPbg8hbt4OXk4UERBc=;
        b=W8iiICVZm4aVPejipGeg3kD5DljfJii5IRhp6THOXJNOKxIsoLjj4EW2rN2RqAjMPW
         sm8iB84gJQFPBPL1f+f171/GdFv82+q9pstb8m+IxBWZmOIbbhwf5aTd8d2f+tWeGIYU
         pcIX0/tXq80stq+Q6m80x8Yw+agHwyEOSxDH0=
X-Forwarded-Encrypted: i=1; AL+hErGYhgwU44oeCfdtIvgJ/BKXiDfUZVIU9gqcYLQSlmPuq91Rr7OsX6AU2KYloEQ5bF/rQ6CCPfwe6/Q=@vger.kernel.org
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr12089853c88.2.1794870560998;
        Mon, 16 Nov 2026 15:09:20 -0800 (PST)
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr12089825c88.2.1794870560347;
        Mon, 16 Nov 2026 15:09:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm35222352c88.6.2026.11.16.15.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:09:19 -0800 (PST)
Message-ID: <1b7b63a6-ef87-4a2d-be3a-ec6ee34c6173@broadcom.com>
Date: Mon, 16 Nov 2026 15:09:17 -0800
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
Subject: Re: [PATCH v4 1/6] phy: broadcom: brcm-sata: Keep NSP ports in the
 shared PCB window
To: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM IPROC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
References: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
 <20261029212513.4126083-2-florian.fainelli@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261029212513.4126083-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/26 14:25, Florian Fainelli wrote:
> Northstar Plus has one PCB register aperture for both SATA ports. Its
> per-port OOB settings use separate banks, while the PLL registers are
> shared.
> 
> The 40nm MDIO refactor made all non-40nm platforms use a 0x1000 per-port
> stride. NSP previously passed the shared base directly to the helpers.
> For port 1, the new stride moves the bank selector from 0x1804033c to
> 0x1804133c in the AHCI register window, outside the PHY resource, and
> prevents the second PHY from being initialized correctly.
> 
> Exclude NSP from the per-port aperture offset in both read and write
> helpers, preserving its existing bank selection.
> 
> Fixes: 0ed41b33882c ("phy: brcm-sata: Correct MDIO operations for 40nm platforms")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   drivers/phy/broadcom/phy-brcm-sata.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
> index fb69e21a0292..b5fb9dff1ae9 100644
> --- a/drivers/phy/broadcom/phy-brcm-sata.c
> +++ b/drivers/phy/broadcom/phy-brcm-sata.c
> @@ -215,9 +215,10 @@ static void brcm_sata_phy_wr(struct brcm_sata_port *port, u32 bank,
>   	void __iomem *pcb_base = priv->phy_base;
>   	u32 tmp;
>   
> +	/* NSP has one shared PCB window; its per-port OOB banks are selected below. */
>   	if (priv->version == BRCM_SATA_PHY_STB_40NM)
>   		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
> -	else
> +	else if (priv->version != BRCM_SATA_PHY_IPROC_NSP)
>   		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
>   
>   	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
> @@ -233,7 +234,7 @@ static u32 brcm_sata_phy_rd(struct brcm_sata_port *port, u32 bank, u32 ofs)
>   
>   	if (priv->version == BRCM_SATA_PHY_STB_40NM)
>   		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
> -	else
> +	else if (priv->version != BRCM_SATA_PHY_IPROC_NSP)
>   		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
>   
>   	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);

Vinod, can you apply this patch now since the other 5 went through their 
respective trees? Thanks!
-- 
Florian
