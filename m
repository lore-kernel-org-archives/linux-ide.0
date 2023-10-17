Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255AC41513
	for <linux-ide@archiver.kernel.org>; Tue, 17 Oct 2023 23:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjJQXIv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Oct 2023 19:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQXIu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Oct 2023 19:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6FA4;
        Tue, 17 Oct 2023 16:08:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF05C433C8;
        Tue, 17 Oct 2023 23:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697584128;
        bh=Qmn/cv9pbKyZyD094B9+g5d/a/JtJybAPrMLLFxlQ2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=trZNIvNo6P66NpnY/WfCIv8B6Jq1ibuMzU9Sq07cAYpa0MhXeVFvcBVWVESTtNu15
         4ic4Prep/HnQZ4ET5Fr7cGit681kPLibNqK8mfPDihjHGH1/IQ7xQ+9XoSkHVP+R2i
         FeIMgcse7Lo12fS2HU58r88oWYV2OaVr0XrlbMMCTqtuTdiu8QHYL2VLNb7drn5U89
         R9h2izpmbq4G81BIyvyAo0My0vUUP4tlUCo1CsQMb/EePkdz0ZOnKGDjpgc9OR48TT
         arC7HmKZ2HJx8s7Rhsvq6BoBfzADqvv21jb/QzLYhpV4EGrRoaz6kEHNPvuce7toWA
         c0vR8IVo55yBg==
Message-ID: <93f6cc7c-54d5-4347-a107-eca1bd5a4ac0@kernel.org>
Date:   Wed, 18 Oct 2023 08:08:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: tegra: Disallow undefined properties
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016155555.2974051-1-robh@kernel.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231016155555.2974051-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/17/23 00:55, Rob Herring wrote:
> Device specific bindings should not allow undefined properties. This is
> accomplished in json-schema with 'additionalProperties: false'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

