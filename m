Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A3CE7A81
	for <linux-ide@archiver.kernel.org>; Mon, 25 Sep 2023 07:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjIYHDL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Sep 2023 03:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjIYHDJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2023 03:03:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0910E
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2023 00:03:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD8AC433C7;
        Mon, 25 Sep 2023 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695625382;
        bh=dtfifQ7U27vFXAW7HYq/4RtxdnH2HTVvpeFkCVhKiiI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oHJTHqaP9xXbSzXOCZyO+DE2hyt9F/VyR0odfvdWP5NqtJP8hM3K+XjTeWUsatFnr
         T0WhhYjSU9V3D4ws8MWAUVAS8pG04g2o5HUN5KFoy1EGxQUKLpm9JDIfp+ILFfgsxK
         rr+3RU/ZCHqIN+FnuIuNlK3G0DuF+GSDI4hlpmt5/OSXHjLZSNoQC5yhAN5WgrfzX9
         jbdTuG28GEVOiKt93m2SoEfxo5pPZ45FMpmyl5vSjL3UkihbGojSnajG8+ufqu2tay
         XwCXgTSHFDExZRbE17Jd/cvRzJlUDjXW5wxcFcMM4ISy2dBsjUPd0SGUnPyUhFG6oD
         56TTkSRWrhLWA==
Message-ID: <6188b764-9d54-f34f-41de-e982820c7b78@kernel.org>
Date:   Mon, 25 Sep 2023 09:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ahci: add identifiers for ASM2116 series devices.
To:     Szuying Chen <chensiying21@gmail.com>, linux-ide@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
References: <20230921093351.14403-1-Chloe_Chen@asmedia.com.tw>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230921093351.14403-1-Chloe_Chen@asmedia.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/09/21 11:33, Szuying Chen wrote:
> Add support for PCIe SATA expander cards based on Asmedia 2116 controllers.
> These cards can provide up to 10 or more SATA port on PCIe card
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Applied to for-6.7. Thanks !


-- 
Damien Le Moal
Western Digital Research

