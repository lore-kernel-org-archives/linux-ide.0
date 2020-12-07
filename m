Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A196C0018C
	for <linux-ide@archiver.kernel.org>; Mon,  7 Dec 2020 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5D32310B
	for <linux-ide@archiver.kernel.org>; Mon,  7 Dec 2020 10:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLGJ7p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:59:45 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2521 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGJ7p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2020 04:59:45 -0500
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CqJfh5ZT0zQpYV;
        Mon,  7 Dec 2020 17:58:36 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Dec 2020 17:59:03 +0800
Received: from DGGEML502-MBX.china.huawei.com ([169.254.2.32]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Mon, 7 Dec 2020 17:58:58 +0800
From:   "wanqian (D)" <wanqian10@huawei.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?Windows-1252?Q?Should_link->eh=5Fcontext.i.serror=92s_value_incorporate?=
 =?Windows-1252?Q?_link->eh=5Finfo.serror_before_doning_ata=5Feh=5Fanalyze?=
 =?Windows-1252?Q?=5Fserror()=3F?=
Thread-Topic: =?Windows-1252?Q?Should_link->eh=5Fcontext.i.serror=92s_value_incorporate?=
 =?Windows-1252?Q?_link->eh=5Finfo.serror_before_doning_ata=5Feh=5Fanalyze?=
 =?Windows-1252?Q?=5Fserror()=3F?=
Thread-Index: AdbMf4obND2XvjaFTkCc58H3tpRQfA==
Date:   Mon, 7 Dec 2020 09:58:57 +0000
Message-ID: <05003591095D3240AA548FBF7CBB20251E8A7327@DGGEML502-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.102.122]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Tejun,
      In SATA EH processing, I found the SERROR register was cleared during interrupt handling in ahci_error_intr(), and its value has been saved to the link->eh_info.serror. 
But the SERROR register value was read again in the ata_eh_link_autopsy(), and its value was saved to link->eh_context.i.serror which is analyzed by ata_eh_analyze_serror().
Obviously, the link->eh_context.i.serror’s value will be zero if no host perceptible error is found after it was cleared in interrupt handler. 
      Why ata_link structure should maintain two ata_eh_info instances: link->eh_info and link->eh_context.i?
      Should link->eh_context.i.serror’s value incorporate link->eh_info.serror before doing ata_eh_analyze_serror()?

Thanks,
Qian Wan
