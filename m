Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBC4C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 31 Oct 2023 05:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJaFNs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Oct 2023 01:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJaFNs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2023 01:13:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C0F9
        for <linux-ide@vger.kernel.org>; Mon, 30 Oct 2023 22:13:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A68C433C8;
        Tue, 31 Oct 2023 05:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698729207;
        bh=KvE4xrScpfYSQplW3kwRMXWFRn2o4YnTSaVDM6zRWyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MhuwhbrCq4bk5WVkzl1afDWbcp1WNQuJygZuQt1ySk0ZsMZSpYPFDEBLuurZQL2G7
         eJVlbxecZWiwvkOVQdX7+r31s2jBpejsq/aIskkN94Xz/pZF/7Hm6vnsZBxpBx2mK1
         vcBiBvKemaXkDqBhR1zhzJPc4UTrpVL3HYVqqBJMSUw7ggOmcdhPZbWiwiaSuYyEL4
         /cA2R/OkjgEn6QL8JbaXdKsp7ILGAVX5TVIjsqUBkgsi+KfNZMfMbcg3K2q4XkSElm
         iCaR5R67er3CuI0FU6CK7hePnVHGMyIBLE4UnrihaCluWDZ292tdNwfXDwJX9EkGBy
         dxLRqQL7/lOOQ==
Message-ID: <4916b09e-ec4b-4106-bd1a-1b86827d8901@kernel.org>
Date:   Tue, 31 Oct 2023 14:13:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pata_isapnp: Add check for devm_ioport_map
Content-Language: en-US
To:     Chen Ni <nichen@iscas.ac.cn>, s.shtylyov@omp.ru, jeff@garzik.org
Cc:     linux-ide@vger.kernel.org
References: <20231031040007.2498659-1-nichen@iscas.ac.cn>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231031040007.2498659-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/31/23 13:00, Chen Ni wrote:
> Add check for devm_ioport_map() and return the error if it fails in
> order to guarantee the success of devm_ioport_map().
> 
> Fixes: 0d5ff566779f ("libata: convert to iomap")

This is the wrong patch. That patch was using pcim_iomap_regions(), not
devm_ioport_map().

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/ata/pata_isapnp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
> index 25a63d043c8e..0f77e0424066 100644
> --- a/drivers/ata/pata_isapnp.c
> +++ b/drivers/ata/pata_isapnp.c
> @@ -82,6 +82,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
>  	if (pnp_port_valid(idev, 1)) {
>  		ctl_addr = devm_ioport_map(&idev->dev,
>  					   pnp_port_start(idev, 1), 1);
> +		if (!ctl_addr)
> +			return -ENOMEM;
> +
>  		ap->ioaddr.altstatus_addr = ctl_addr;
>  		ap->ioaddr.ctl_addr = ctl_addr;
>  		ap->ops = &isapnp_port_ops;

-- 
Damien Le Moal
Western Digital Research

