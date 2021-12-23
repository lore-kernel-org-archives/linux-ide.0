Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F2AC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 23 Dec 2021 18:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbhLWSrP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:47:15 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:58790 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349879AbhLWSrO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Dec 2021 13:47:14 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 7CDD12072122
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 43/68] libata: drop ata_msg_info()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211221072131.46673-1-hare@suse.de>
 <20211221072131.46673-44-hare@suse.de>
 <4fd38f6e-b804-1356-9a13-d35f9ddfa660@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d5ddd55a-c774-f9db-720c-b8ff4d818c80@omp.ru>
Date:   Thu, 23 Dec 2021 21:47:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4fd38f6e-b804-1356-9a13-d35f9ddfa660@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/23/21 12:48 PM, Sergey Shtylyov wrote:

[...]
>> Convert the sole caller to ata_dev_deb() and remove the definition.
> 
>    ata_dev_info() actually (as follows from the patch)?

   Sorry, ata_dev_dbg()... :-/

> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
[...]

MBR, Sergey
