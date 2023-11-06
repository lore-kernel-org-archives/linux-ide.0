Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5BC4332F
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 09:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjKFJCL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Nov 2023 04:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFJCK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2023 04:02:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FF883
        for <linux-ide@vger.kernel.org>; Mon,  6 Nov 2023 01:02:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8B2C433C7;
        Mon,  6 Nov 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699261326;
        bh=LM9LkG2R6SxG/4/Nz6kCDGn2eDIUpbjkacN8lSGoGSE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=uP1cJU6E+TWp4ZOXJFHwxbCoVNjOlNS04Ik+eeaevQmCVaEN85u0IHYr+yTzEY7Df
         CeXvK6WZTMzLmLvNA3UKe1MMKBh283hzsa06PrhnDwXUEY+Vk91u6nYeL2l9zh7Bt1
         bS6082jJ6gUY3vbXxx2dtw012AQ8zVu2BlBqmp8THlyuQanpMKL9Y6O5sCRk7cX5G3
         nuVrYOrPu5zZhflF08TWhsbhZSRF7pRgQzlq9McqOA7iz+dOuebc+UuzlEy1YBifKe
         VUgIGdT5g+cmJGoWMMaZNpg7cuqy1+dgEHeEbma8gnvLSlbkGujksGlF2SZWgjRavZ
         NBwjM1aHfenqg==
Message-ID: <2350d653-24cb-4199-a000-ac3ce151cc3a@kernel.org>
Date:   Mon, 6 Nov 2023 18:02:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Fix ata_pci_shutdown_one()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20231106041658.85522-1-dlemoal@kernel.org>
 <07854fac-f626-785f-2af6-41d85ce53c39@omp.ru>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <07854fac-f626-785f-2af6-41d85ce53c39@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/6/23 17:47, Sergey Shtylyov wrote:
> Hello!
> 
> On 11/6/23 7:16 AM, Damien Le Moal wrote:
> 
>> Commit 5b6fba546da2 ("ata: libata-core: Detach a port devices on
>> shutdown") modified the function ata_pci_shutdown_one() to stop
>> (suspend) devices attached to the ports of a PCI AHCI adapter to ensure
>> that drives are spun down before shutting down a system. However, this
>> is done only for PCI adapters and not for other types of adapters. This
>> limitation was addressed with commit 24eca2dce0f8 ("scsi: sd: Introduce
>> manage_shutdown device flag"). With this, all ATA disks are spun down on
>> system shutdown.
>>
>> This reverts commit 5b6fba546da2 as the change introduced is now
>> useless.
> 
>    You didn't use 'git revert'?

I did, but I wrote a proper commit message.

> 
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

