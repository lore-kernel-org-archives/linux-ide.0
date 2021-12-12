Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C88AC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 12 Dec 2021 09:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhLLJTB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Dec 2021 04:19:01 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:44390 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhLLJTA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2021 04:19:00 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 91F7720C5C41
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <5cebbfc6-c763-734c-ddc2-5b9ffa3d3f38@omp.ru>
Date:   Sun, 12 Dec 2021 12:18:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 67/68] sata_dwc_460ex: remove 'checkstatus' argument
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211210072905.15666-1-hare@suse.de>
 <20211210072905.15666-68-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211210072905.15666-68-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 10.12.2021 10:29, Hannes Reinecke wrote:

> Remove the 'checkstatus' argument from sata_dwc_qc_complete() and

    It's 'check_status' actually, here and in the subject. :-)

> sata_dwc_dma_xfer_complete() as it has no functionality.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
[...]

MBR, Sergey
