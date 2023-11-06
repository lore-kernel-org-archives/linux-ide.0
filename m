Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98772C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 08:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjKFIrR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Nov 2023 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjKFIrR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2023 03:47:17 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E2DC9
        for <linux-ide@vger.kernel.org>; Mon,  6 Nov 2023 00:47:13 -0800 (PST)
Received: from [192.168.1.103] (178.176.78.237) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 6 Nov
 2023 11:47:05 +0300
Subject: Re: [PATCH] ata: libata-core: Fix ata_pci_shutdown_one()
To:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
References: <20231106041658.85522-1-dlemoal@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <07854fac-f626-785f-2af6-41d85ce53c39@omp.ru>
Date:   Mon, 6 Nov 2023 11:47:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231106041658.85522-1-dlemoal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.237]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/06/2023 08:31:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181124 [Nov 06 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.237 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.237 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.78.237:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.237
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/06/2023 08:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/6/2023 6:21:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 11/6/23 7:16 AM, Damien Le Moal wrote:

> Commit 5b6fba546da2 ("ata: libata-core: Detach a port devices on
> shutdown") modified the function ata_pci_shutdown_one() to stop
> (suspend) devices attached to the ports of a PCI AHCI adapter to ensure
> that drives are spun down before shutting down a system. However, this
> is done only for PCI adapters and not for other types of adapters. This
> limitation was addressed with commit 24eca2dce0f8 ("scsi: sd: Introduce
> manage_shutdown device flag"). With this, all ATA disks are spun down on
> system shutdown.
> 
> This reverts commit 5b6fba546da2 as the change introduced is now
> useless.

   You didn't use 'git revert'?

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
[...]

MBR, Sergey
