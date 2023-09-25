Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5577CE7A89
	for <linux-ide@archiver.kernel.org>; Mon, 25 Sep 2023 07:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjIYHMW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Sep 2023 03:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjIYHMT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2023 03:12:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF3136;
        Mon, 25 Sep 2023 00:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90360C433CD;
        Mon, 25 Sep 2023 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695625931;
        bh=6Dr90FXidnenbYzY2VdDgQp3Cbw7imf3JMYhlHYthww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WQb5w9gYIlCIasAEgSIf/oexPVyKpMoDU3WbMlURebjGMkLD+r3bNQFYG/y+duPdX
         0cA9uDSBgdeaSBjuU8ziiOcXE+fkmTL+zstI0COL+dM44AbsCvK5nnV+eNc7ojcwXV
         pL0lyfQFn4rABMpqKf2TgdgwNue6kaxZ4geygT7WMZUYMkYzKG3asUe+nZazoHPusm
         vJkU7HLIoX/68tXJ4EspOHRJZ+/tcPHHDDrCOIWjGmnF4Vh+dnliux82QJLM5KY3uG
         XUsIh4YIj+HcR9oQm/vSU0XczCUBH9vga4xRKk7Z2xMIgmRBRf2DKf3OvzUpJOagsb
         wctBwxf4RyV3w==
Message-ID: <b55b0ec2-7afe-3c63-64b7-ae748db8b7ec@kernel.org>
Date:   Mon, 25 Sep 2023 09:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ata: libata: increase PMP SRST timeout to 10s
Content-Language: en-US
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d55400d247e5f00f7c72af2ba442da7b1bed760f.1695415885.git.mschiffer@universe-factory.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d55400d247e5f00f7c72af2ba442da7b1bed760f.1695415885.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/09/22 22:55, Matthias Schiffer wrote:
> On certain SATA controllers, softreset fails after wakeup from S2RAM with
> the message "softreset failed (1st FIS failed)", sometimes resulting in
> drives not being detected again. With the increased timeout, this issue
> is avoided. Instead, "softreset failed (device not ready)" is now
> logged 1-2 times; this later failure seems to cause fewer problems
> however, and the drives are detected reliably once they've spun up and
> the probe is retried.
> 
> The issue was observed with the primary SATA controller of the QNAP
> TS-453B, which is an "Intel Corporation Celeron/Pentium Silver Processor
> SATA Controller [8086:31e3] (rev 06)" integrated in the Celeron J4125 CPU,
> and the following drives:
> 
> - Seagate IronWolf ST12000VN0008
> - Seagate IronWolf ST8000NE0004
> 
> The SATA controller seems to be more relevant to this issue than the
> drives, as the same drives are always detected reliably on the secondary
> SATA controller on the same board (an ASMedia 106x) without any "softreset
> failed" errors even without the increased timeout.
> 
> Fixes: e7d3ef13d52a ("libata: change drive ready wait after hard reset to 5s")
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Applied to for-6.6-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

