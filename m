Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D10E784A4
	for <linux-ide@archiver.kernel.org>; Tue,  3 Oct 2023 00:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjJCAfL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Oct 2023 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbjJCAfJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2023 20:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2548FD;
        Mon,  2 Oct 2023 17:34:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F10C433AB;
        Tue,  3 Oct 2023 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696293293;
        bh=p6qznuAAZAoVYgv+yLDynMUW18PfarM3W+3DEN8LiZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tXd812b+8N7UHHGjNi5N9CJZSBsgKg98xPHAFvLv9vlFPZmA6ZU6Tae9+8d754m+L
         BGcH+1CH4KcIleBHl1T6r/u5sCMb+ToJ9cL8GrfGlmsCmhaRA7+0OwK+0N/URh2W9V
         D4h7b6wrNVH6riW78xxPo9QBzzlEj2mJvVoBv+g7Ydkad4MUil/9FfkN0bc4d75AfK
         hAgFGSBScloRfzDSOEmzYInjO9C59dM+pC8+jfVDphRy7kU/ug6rOuws5JMSruHIZB
         pEL7VUz/YbmmkKH22TEeEx6STJZai90ZSXP6iGB2VLTUWL/3X+xbWI3nm2M0oaT4ZW
         Ys4O9gmTvPU+g==
Message-ID: <3c9e7243-f95f-9796-7e73-5e7a9ca16db3@kernel.org>
Date:   Tue, 3 Oct 2023 09:34:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] pata_parport: fix EXP Computer CD-865 with MC-1285B
 EPP cable
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230930191511.24994-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/1/23 04:15, Ondrej Zary wrote:
> 
> Two bugfixes, one workaround and IDE command set registers support for fit3
> driver. All needed for EXP Computer CD-865 drive with MC-1285B EPP cable to
> work.
> 

Please use my email address listed by get_maintainer.pl: dlemoal@kernel.org

And these patches do not involve linux-block and Jens, so no need to send there
(that reduces noise on the block list).

-- 
Damien Le Moal
Western Digital Research

