Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E9C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 14 Feb 2022 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiBNVOE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:14:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBNVOE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2022 16:14:04 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB081354B6;
        Mon, 14 Feb 2022 13:13:55 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 4A0D2208CD1B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: add/use ata_taskfile::{error|status} fields
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <e99172ca-cf0e-5510-60fc-b19dc48658ac@omp.ru>
Organization: Open Mobile Platform
Message-ID: <49690264-a2b8-b11e-e944-1d2333f73334@omp.ru>
Date:   Tue, 15 Feb 2022 00:13:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e99172ca-cf0e-5510-60fc-b19dc48658ac@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/14/22 11:43 PM, Sergey Shtylyov wrote:

> Add the explicit error and status register fields to 'struct ata_taskfile'
> using the anonymous *union*s ('struct ide_taskfile' had that for ages!) and
> update the libata taskfile code accordingly. There should be no object code
> changes resulting from that...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo plus just posted 'drivers/ata/libata-scsi.c' patch.

   Oh, and the 2 patch series for 'drivers/ata/libata-sff.c' posted not so long ago...
There are only some offsets, so should probably apply indeptendently as well... :-)

MBR, Sergey
