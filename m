Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50812EB64D9
	for <linux-ide@archiver.kernel.org>; Tue, 20 Jun 2023 01:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFTBS3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjFTBSV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2023 21:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AF1991;
        Mon, 19 Jun 2023 18:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6EC860F66;
        Tue, 20 Jun 2023 01:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E8AC433C8;
        Tue, 20 Jun 2023 01:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687223867;
        bh=JhZIMKUZdfUZG1G2LF/l44rtxC/mRDQxMAGxL8IUqvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dh3bgcsgx6qDhure1EUvQAns9alftceykHkXtqxvGfbodjpMqtPMmp98jFNhAOG1r
         1NDK1Vlh9h/96366cR9HLSV56f1OSv7AtkVF9pLFv13vIQfv71/hL2/K/eNt4buEIx
         J097jL1vOOAeKlcq+oVS0UBga6BidT18AZV2uIzjcJt9gyWjqMtXYmAXB+zbfJInVH
         co4pU5/FT/b3Q44fR4qPO3XDN/nPx2sdDHTv/tGj41xSPFSKgp1Y9vRxIeYEd3yyH5
         rgQ8YKDEMSQLrb0iaXF1UFhNa30I8saTcL0HLEgkZaX3H5GwuDyhV5O+aMO+1wCXWW
         9/02GYdE0TbJw==
Message-ID: <3b7c6fee-4af3-5541-5c24-a290e3243164@kernel.org>
Date:   Tue, 20 Jun 2023 10:17:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/5] Add RK3588 SATA support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230612171337.74576-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/13/23 02:13, Sebastian Reichel wrote:
> Hi,
> 
> This enables SATA support for RK3588.

Applied 1-3 to libata for-6.5 branch. Thanks !



-- 
Damien Le Moal
Western Digital Research

