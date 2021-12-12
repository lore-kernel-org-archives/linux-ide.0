Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD4C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 12 Dec 2021 09:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhLLJw0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Dec 2021 04:52:26 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:54646 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhLLJw0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2021 04:52:26 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 9EC5D20EC9A8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <ae7185a8-66bf-4324-45b0-832b86652e4f@omp.ru>
Date:   Sun, 12 Dec 2021 12:52:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 28/68] sata_promise: Drop pointless VPRINTK() calls and
 convert the remaining ones
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
CC:     <linux-ide@vger.kernel.org>
References: <20211210072905.15666-1-hare@suse.de>
 <20211210072905.15666-29-hare@suse.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211210072905.15666-29-hare@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10.12.2021 10:28, Hannes Reinecke wrote:

> Drop pointless VPRINTK() calls for entering and existing interrupt
> routines and convert the remaining calls to dev_dbg().

    ata_port_dbg() really...

> Signed-off-by: Hannes Reinecke <hare@suse.de>
[...]

MBR, Sergey
