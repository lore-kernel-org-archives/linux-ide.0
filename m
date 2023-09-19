Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F5CE79A9
	for <linux-ide@archiver.kernel.org>; Tue, 19 Sep 2023 17:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjISRTi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjISRTi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2023 13:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DEA6;
        Tue, 19 Sep 2023 10:19:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FF1C433C8;
        Tue, 19 Sep 2023 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695143972;
        bh=0FzohlduMMKtgDdiJ9ExxJvjBavWbhnZ0AuCWrDjN+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nuY/o1OyGCMXR9OIR6jCcLNIYS6JF7AMiw9dwXcWYrqFlUUiRAfCsGPV31bElxvSd
         tw0pUR1LK49PmCn40U0ITagB5IkWTR215i6ve09R6qATJRC1YJfX4dnIBhLVTLmHV5
         QBYsHv1unE0uy+4eZwLtYxN4jEe43MDBrR/VXzqndRwVfQeNC9EhXRxAZCe/8ZD6ja
         q5vOGQ4zlN+y7ImENkcdLdkdC4vv9OWqaZBqRfm5wppXs6uzN9U07DIzl0fwFJqtxQ
         aeVGP9rl6Msc5Hltj1iRUskRGoDAWd+KgKTH0PRQBfzLh+6r9xzADjKmwh7xM53Hn+
         kr7UHLWw6zqsA==
Message-ID: <18e21ab0-fcd3-590f-af89-95e1b141acb3@kernel.org>
Date:   Tue, 19 Sep 2023 10:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: ata: pata-common: Add missing
 additionalProperties on child nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230915201626.4180606-1-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230915201626.4180606-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/09/15 13:16, Rob Herring wrote:
> The PATA child node schema is missing constraints to prevent unknown
> properties. As none of the users of this common binding extend the child
> nodes with additional properties, adding "additionalProperties: false"
> here is sufficient.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.6-fixes. Thanks !

> ---
>  Documentation/devicetree/bindings/ata/pata-common.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/pata-common.yaml b/Documentation/devicetree/bindings/ata/pata-common.yaml
> index 337ddf1113c4..4e867dd4d402 100644
> --- a/Documentation/devicetree/bindings/ata/pata-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/pata-common.yaml
> @@ -38,6 +38,7 @@ patternProperties:
>        ID number 0 and the slave drive will have ID number 1. The PATA port
>        nodes will be named "ide-port".
>      type: object
> +    additionalProperties: false
>  
>      properties:
>        reg:

-- 
Damien Le Moal
Western Digital Research

