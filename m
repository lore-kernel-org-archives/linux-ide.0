Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F698C001DE
	for <linux-ide@archiver.kernel.org>; Wed, 26 Jul 2023 23:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjGZXpX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGZXpW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jul 2023 19:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE52135;
        Wed, 26 Jul 2023 16:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30B661CE2;
        Wed, 26 Jul 2023 23:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD6C433C7;
        Wed, 26 Jul 2023 23:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690415121;
        bh=pswvlk0rv9q0ZAF4xafe2oGNPXfZhIoRZDhMjRbAWtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=so4vX3ACqE8266USjgITPYC0q8sPPePqUJVptSocGKzEwQSEW/LZ+V6aqH6N8yMEP
         1gMMB92tI5Osjoxkec/dxJO9mYV2i2zhBtj06YUe/CZ+kRIIyG29+9qF6HdPBbOoqy
         vou1WBU15AL4OngAK+tcTaTN9WHl4fcjZMivZ10npwKwwnDis5sD9ftTZUYKMgL1+/
         MTAexjo2FHcY6XC0eOm9jzmUOAseu2pO+L70CCjRLlgC+Zevdfg6Aw0mH7TIJd97hk
         OE4CLRjRkME27qgMD6jR3RKNKI5MFfxTXpVrlW1/6nPbjAJBmefrfwcQlJ++Vvibby
         cy/kk70KiajWA==
Message-ID: <ce6e2fbe-1c74-44e1-7499-5542747426bd@kernel.org>
Date:   Thu, 27 Jul 2023 08:45:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [v2] ata: pata_ns87415: mark ns87560_tf_read static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726203354.946631-1-arnd@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726203354.946631-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/27/23 05:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The global function triggers a warning because of the missing prototype
> 
> drivers/ata/pata_ns87415.c:263:6: warning: no previous prototype for 'ns87560_tf_read' [-Wmissing-prototypes]
>   263 | void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> 
> There are no other references to this, so just make it static.
> 
> Fixes: c4b5b7b6c4423 ("pata_ns87415: Initial cut at 87415/87560 IDE support")
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-6.5-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

