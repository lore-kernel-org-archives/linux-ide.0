Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547CC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 19:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiBDTIJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:08:09 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:58124 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiBDTII (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 14:08:08 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 704AD205E53E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] libata: use *switch* in artop_init_one()
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <660a1f84-5607-0f9a-be70-e0407c3d85e2@omp.ru>
Organization: Open Mobile Platform
Message-ID: <261bd360-c0f0-913c-8e96-4d1cfe0f1191@omp.ru>
Date:   Fri, 4 Feb 2022 22:08:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <660a1f84-5607-0f9a-be70-e0407c3d85e2@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/4/22 3:24 PM, Sergey Shtylyov wrote:

> This driver uses a string of the *if* statements where a *switch* statement
> fits better...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
> Changes in version 2:
> - updated #define DRV_VERSION.

   Oops, wrong prefix in the subject, posting v3...

[...]

MBR, Sergey
