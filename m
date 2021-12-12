Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8DAC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 12 Dec 2021 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhLLJVF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Dec 2021 04:21:05 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:59802 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhLLJVF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2021 04:21:05 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 5A8C820D569B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <3e38a7a7-89ca-cf99-123e-42cc98b2ab1b@omp.ru>
Date:   Sun, 12 Dec 2021 12:21:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 46/68] libata: remove debug compilation switches
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211210072905.15666-1-hare@suse.de>
 <20211210072905.15666-47-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211210072905.15666-47-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10.12.2021 10:28, Hannes Reinecke wrote:

> Unused now, so remove them and any reference to it.

    s/it/them/?

> Signed-off-by: Hannes Reinecke <hare@suse.de>
[...]

MBR, Sergey
