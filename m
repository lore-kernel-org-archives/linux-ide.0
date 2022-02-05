Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC8FC433F5
	for <linux-ide@archiver.kernel.org>; Sat,  5 Feb 2022 18:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354354AbiBEStj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Feb 2022 13:49:39 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:58812 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348137AbiBESti (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2022 13:49:38 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 22987205F4E8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] pata_hpt3x2n: check channel enable bits
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <66e64122-6201-4ae6-3c20-002ec929d5be@omp.ru>
 <69c6041e-1b50-7aaa-d07e-021335c4704a@omp.ru>
Organization: Open Mobile Platform
Message-ID: <64ccb842-c9bb-477c-d407-02e7912e8003@omp.ru>
Date:   Sat, 5 Feb 2022 21:49:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <69c6041e-1b50-7aaa-d07e-021335c4704a@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/5/22 9:43 PM, Sergey Shtylyov wrote:

>> The dirver's prereset() method still doesn't check the channel enable bits.
> 
>    s/dirver/driver/, pleasee fix when applying! :-)

   I forgot to update DRV_VERSION, so v2 is iun order anyway.

>> The bug was there for the entire time the driver has existed. :-/
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
