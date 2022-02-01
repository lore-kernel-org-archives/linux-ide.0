Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E83DC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  1 Feb 2022 20:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiBAUqB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:46:01 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:55766 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbiBAUqB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2022 15:46:01 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 7A28221DD403
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] libata: kill ata_acpi_on_suspend()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <6641085e-0459-fb1d-a8f1-c928e15ccc91@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a5a4f209-e9ca-8b6a-9a41-ff0b0ccea2ba@omp.ru>
Date:   Tue, 1 Feb 2022 23:45:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6641085e-0459-fb1d-a8f1-c928e15ccc91@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/22 11:04 PM, Sergey Shtylyov wrote:

> Since the commit c05e6ff035c1b25d17364a685432 ("libata-acpi: implement
> and use ata_acpi_init_gtm()") ata_acpi_on_suspend() just returns 0, so
> its call from ata_eh_handle_port_suspend() doesn't make sense anymore.
> Remove the function completely, at last...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/libata-acpi.c |   21 ---------------------
>  drivers/ata/libata-eh.c   |    7 +------
>  2 files changed, 1 insertion(+), 27 deletions(-)

  Grrr! drivers/ata/libata.h somehow wasn't included in the patch. I'll repost....

MBR, Sergey
