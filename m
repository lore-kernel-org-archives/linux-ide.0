Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3039FC4338F
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 12:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1944A600D4
	for <linux-ide@archiver.kernel.org>; Wed, 18 Aug 2021 12:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhHRM7Q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Aug 2021 08:59:16 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49257 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236124AbhHRM7Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 18 Aug 2021 08:59:16 -0400
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7CFD561E5FE33;
        Wed, 18 Aug 2021 14:58:40 +0200 (CEST)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Failed disk initialization logged as warning `ata3.00: disabled`
 instead with more severe log level
Message-ID: <e5cc55d4-ef08-cd57-f1b0-cd15df43dc8b@molgen.mpg.de>
Date:   Wed, 18 Aug 2021 14:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Linux folks,


A disk died on an old system, and is not displayed by `lsblk` anymore 
after a reboot. I would have expected such an event be logged with a 
severe level.

     @moppel:~$ dmesg --level=emerg
     @moppel:~$ dmesg --level=alert
     @moppel:~$ dmesg --level=crit
     @moppel:~$ dmesg --level=err
     [   24.450604] ata3.00: failed to set xfermode (err_mask=0x4)
     [   39.810617] ata3.00: failed to set xfermode (err_mask=0x4)
     @moppel:~$ dmesg --level=warn
     [    1.039497] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
     [    2.539408] pci 0000:03:00.0: can't disable ASPM; OS doesn't 
have ASPM control
     [    3.088540] ACPI Warning: SystemIO range 
0x0000000000000428-0x000000000000042F conflicts with OpRegion 
0x0000000000000400-0x000000000000047F (\PMIO) (20200925/utaddress-213)
     [    3.114469] ACPI Warning: SystemIO range 
0x0000000000000540-0x000000000000054F conflicts with OpRegion 
0x0000000000000500-0x0000000000000563 (\GPIO) (20200925/utaddress-213)
     [    3.140390] ACPI Warning: SystemIO range 
0x0000000000000530-0x000000000000053F conflicts with OpRegion 
0x0000000000000500-0x0000000000000563 (\GPIO) (20200925/utaddress-213)
     [    3.166311] ACPI Warning: SystemIO range 
0x0000000000000500-0x000000000000052F conflicts with OpRegion 
0x0000000000000500-0x0000000000000563 (\GPIO) (20200925/utaddress-213)
     [    3.192226] lpc_ich: Resource conflict(s) found affecting gpio_ich
     [    3.900324] i8042: PNP: PS/2 controller doesn't have KBD irq; 
using default 1
     [    9.086414] ata3.00: qc timeout (cmd 0x27)
     [    9.090618] ata3.00: failed to read native max address 
(err_mask=0x4)
     [    9.097155] ata3.00: HPA support seems broken, skipping HPA handling
     [   24.446401] ata3.00: qc timeout (cmd 0xef)
     [   24.456189] ata3: limiting SATA link speed to 1.5 Gbps
     [   24.461423] ata3.00: limiting speed to UDMA/133:PIO3
     [   39.806416] ata3.00: qc timeout (cmd 0xef)
     [   39.816203] ata3.00: disabled

The xfermode message is logged as an error, but I have system, where the 
device is still functional. The actual disabled message is “only” logged 
as a warning.

Is there a way to improve the logging, and log a failed initialization 
of a disk with a higher level? Maybe even critical or alert?


Kind regards,

Paul
