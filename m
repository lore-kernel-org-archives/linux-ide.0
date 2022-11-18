Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B3AC4332F
	for <linux-ide@archiver.kernel.org>; Fri, 18 Nov 2022 19:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiKRTYW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRTYV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2022 14:24:21 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1F6B237
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2022 11:24:19 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:References;
        bh=zB7n78IJxVySa0hmXtpRg+80gE1uyHA1ZTi+ZbFbNw4=;
        b=kXf5E2T09/HVDUKcfgeBtR6YOEvdqSiXNjV970o9agFhGj4FpPRBfVtYwUimyywbfB6PhOP3qQMAAcrqYpTu2NQtk/aCjGBEIovQWSKHHSDfj9S/S0OIVETfVhH2wI0k6D5T3oRjDpn/IQzsvNO2Wh03yAB6Dz+v0Me24OffXT4KMY+MMAN/2cuko739JgnJdwAKp04HdiQQwvB9/xa47WDLa6oe+TmtGRFWUxS8wzabIWZ958kowyajaq
        KRkf7NqrC8k6pl2jTDpmyG9Tj7QJrstU74BaU6FF4YeGr13yl8T6bWr7F9xz3ULKO+xusd1SrUvEO27FkVcDOS0zToWQ==
Received: from graph (86-122-18-201.dynamic.brasov.rdsnet.ro [86.122.18.201])
        by mx1.wiredblade.com with ESMTPSA
        (version=TLSv1 cipher=AES128-SHA bits=128)
        ; Fri, 18 Nov 2022 19:24:08 +0000
Message-ID: <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
From:   "Dinu Marius" <marius@psihoexpert.ro>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     <linux-ide@vger.kernel.org>
References: <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com> <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com> <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com> <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com> <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com> <ABCCF36A7F484055A8E63A8B739DC7B8@graph> <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro> <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro> <40f4ae2000164863253c67d405e4f875@psihoexpert.ro> <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro> <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro> <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
Subject: Re: Bug report for ahci-mvebu driver
Date:   Fri, 18 Nov 2022 20:24:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.4657
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I checked the cable and connections. Everything looks OK. The cable is ~ 40cm 
long.

I made these timeout changes:

const unsigned long sata_deb_timing_normal[]  = {   5,  1000, 20000 };
const unsigned long sata_deb_timing_hotplug[]  = {  25,  5000, 20000 };

And I have these results:

[  180.907460][  T104] hardreset, Online=>Offline
[  180.912991][  T104] resume, do loop
[  181.140866][  T104] resume, after do loop
[  181.200866][  T104] debounce, SCR: 0x100
[  181.250866][  T104] debounce, SCR: 0x101
[  181.300866][  T104] debounce, SCR: 0x100
[  181.360866][  T104] debounce, SCR: 0x100
[  181.410866][  T104] debounce, SCR: 0x100
[  181.470866][  T104] debounce, SCR: 0x100
[  181.520866][  T104] debounce, SCR: 0x101
[  181.580866][  T104] debounce, SCR: 0x100
[  181.640866][  T104] debounce, SCR: 0x101
[  181.700866][  T104] debounce, SCR: 0x100
[  181.760865][  T104] debounce, SCR: 0x100
[  181.810869][  T104] debounce, SCR: 0x100
[  181.860866][  T104] debounce, SCR: 0x100
[  181.910866][  T104] debounce, SCR: 0x101
[  181.970866][  T104] debounce, SCR: 0x100
[  182.020866][  T104] debounce, SCR: 0x100
[  182.080866][  T104] debounce, SCR: 0x100
[  182.140866][  T104] debounce, SCR: 0x100
[  182.190866][  T104] debounce, SCR: 0x101
[  182.250866][  T104] debounce, SCR: 0x100
[  182.310866][  T104] debounce, SCR: 0x100
[  182.360866][  T104] debounce, SCR: 0x100
[  182.420866][  T104] debounce, SCR: 0x100
[  182.480866][  T104] debounce, SCR: 0x100
[  182.540866][  T104] debounce, SCR: 0x100
[  182.590866][  T104] debounce, SCR: 0x100
[  182.650866][  T104] debounce, SCR: 0x100
[  182.710866][  T104] debounce, SCR: 0x100
[  182.770866][  T104] debounce, SCR: 0x100
[  182.830869][  T104] debounce, SCR: 0x101
[  182.890866][  T104] debounce, SCR: 0x100
[  182.950866][  T104] debounce, SCR: 0x100
[  183.010865][  T104] debounce, SCR: 0x100
[  183.060866][  T104] debounce, SCR: 0x100
[  183.110870][  T104] debounce, SCR: 0x100
[  183.170866][  T104] debounce, SCR: 0x100
[  183.230866][  T104] debounce, SCR: 0x100
[  183.290865][  T104] debounce, SCR: 0x100
[  183.350869][  T104] debounce, SCR: 0x101
[  183.400866][  T104] debounce, SCR: 0x100
[  183.450866][  T104] debounce, SCR: 0x100
[  183.510866][  T104] debounce, SCR: 0x101
[  183.570866][  T104] debounce, SCR: 0x100
[  183.630866][  T104] debounce, SCR: 0x101
[  183.680866][  T104] debounce, SCR: 0x100
[  183.730866][  T104] debounce, SCR: 0x100
[  183.790866][  T104] debounce, SCR: 0x100
[  183.840865][  T104] debounce, SCR: 0x100
[  183.900866][  T104] debounce, SCR: 0x101
[  183.960866][  T104] debounce, SCR: 0x100
[  184.010866][  T104] debounce, SCR: 0x100
[  184.060866][  T104] debounce, SCR: 0x101
[  184.120866][  T104] debounce, SCR: 0x100
[  184.170866][  T104] debounce, SCR: 0x100
[  184.230866][  T104] debounce, SCR: 0x100
[  184.280866][  T104] debounce, SCR: 0x100
[  184.340866][  T104] debounce, SCR: 0x100
[  184.390866][  T104] debounce, SCR: 0x0
[  184.440866][  T104] debounce, SCR: 0x0
[  184.490866][  T104] debounce, SCR: 0x0
[  184.550866][  T104] debounce, SCR: 0x0
[  184.610866][  T104] debounce, SCR: 0x100
[  184.670866][  T104] debounce, SCR: 0x100
[  184.720866][  T104] debounce, SCR: 0x100
[  184.780866][  T104] debounce, SCR: 0x100
[  184.840866][  T104] debounce, SCR: 0x100
[  184.890868][  T104] debounce, SCR: 0x100
[  184.940865][  T104] debounce, SCR: 0x100
[  184.990865][  T104] debounce, SCR: 0x100
[  185.050865][  T104] debounce, SCR: 0x100
[  185.110866][  T104] debounce, SCR: 0x100
[  185.160865][  T104] debounce, SCR: 0x100
[  185.210866][  T104] debounce, SCR: 0x100
[  185.260866][  T104] debounce, SCR: 0x100
[  185.320866][  T104] debounce, SCR: 0x100
[  185.380865][  T104] debounce, SCR: 0x100
[  185.440866][  T104] debounce, SCR: 0x100
[  185.500866][  T104] debounce, SCR: 0x101
[  185.560866][  T104] debounce, SCR: 0x100
[  185.620866][  T104] debounce, SCR: 0x101
[  185.680866][  T104] debounce, SCR: 0x100
[  185.740866][  T104] debounce, SCR: 0x101
[  185.800866][  T104] debounce, SCR: 0x100
[  185.860865][  T104] debounce, SCR: 0x100
[  185.910869][  T104] debounce, SCR: 0x100
[  185.970866][  T104] debounce, SCR: 0x100
[  186.020866][  T104] debounce, SCR: 0x100
[  186.070866][  T104] debounce, SCR: 0x100
[  186.130866][  T104] debounce, SCR: 0x101
[  186.190866][  T104] debounce, SCR: 0x100
[  186.250866][  T104] debounce, SCR: 0x101
[  186.310866][  T104] debounce, SCR: 0x100
[  186.370866][  T104] debounce, SCR: 0x100
[  186.420869][  T104] debounce, SCR: 0x101
[  186.480866][  T104] debounce, SCR: 0x100
[  186.530866][  T104] debounce, SCR: 0x101
[  186.590866][  T104] debounce, SCR: 0x100
[  186.650866][  T104] debounce, SCR: 0x101
[  186.710866][  T104] debounce, SCR: 0x100
[  186.760866][  T104] debounce, SCR: 0x100
[  186.820865][  T104] debounce, SCR: 0x100
[  186.880865][  T104] debounce, SCR: 0x100
[  186.940868][  T104] debounce, SCR: 0x100
[  187.000866][  T104] debounce, SCR: 0x100
[  187.060865][  T104] debounce, SCR: 0x101
[  187.120866][  T104] debounce, SCR: 0x100
[  187.170866][  T104] debounce, SCR: 0x100
[  187.230865][  T104] debounce, SCR: 0x100
[  187.280869][  T104] debounce, SCR: 0x101
[  187.330866][  T104] debounce, SCR: 0x101
[  187.380866][  T104] debounce, SCR: 0x100
[  187.440865][  T104] debounce, SCR: 0x100
[  187.500866][  T104] debounce, SCR: 0x100
[  187.550866][  T104] debounce, SCR: 0x100
[  187.600866][  T104] debounce, SCR: 0x100
[  187.660866][  T104] debounce, SCR: 0x100
[  187.710866][  T104] debounce, SCR: 0x101
[  187.770866][  T104] debounce, SCR: 0x100
[  187.820866][  T104] debounce, SCR: 0x100
[  187.880866][  T104] debounce, SCR: 0x100
[  187.930865][  T104] debounce, SCR: 0x100
[  187.980866][  T104] debounce, SCR: 0x101
[  188.030866][  T104] debounce, SCR: 0x100
[  188.090866][  T104] debounce, SCR: 0x100
[  188.140866][  T104] debounce, SCR: 0x100
[  188.200866][  T104] debounce, SCR: 0x100
[  188.250866][  T104] debounce, SCR: 0x101
[  188.310866][  T104] debounce, SCR: 0x100
[  188.360866][  T104] debounce, SCR: 0x100
[  188.420865][  T104] debounce, SCR: 0x100
[  188.470869][  T104] debounce, SCR: 0x100
[  188.530866][  T104] debounce, SCR: 0x101
[  188.580866][  T104] debounce, SCR: 0x100
[  188.640866][  T104] debounce, SCR: 0x100
[  188.700866][  T104] debounce, SCR: 0x100
[  188.750866][  T104] debounce, SCR: 0x100
[  188.810866][  T104] debounce, SCR: 0x100
[  188.870866][  T104] debounce, SCR: 0x100
[  188.930866][  T104] debounce, SCR: 0x101
[  188.980869][  T104] debounce, SCR: 0x0
[  189.040866][  T104] debounce, SCR: 0x0
[  189.100866][  T104] debounce, SCR: 0x0
[  189.160866][  T104] debounce, SCR: 0x0
[  189.220866][  T104] debounce, SCR: 0x100
[  189.270865][  T104] debounce, SCR: 0x101
[  189.330865][  T104] debounce, SCR: 0x100
[  189.390866][  T104] debounce, SCR: 0x101
[  189.450865][  T104] debounce, SCR: 0x100
[  189.500866][  T104] debounce, SCR: 0x101
[  189.560866][  T104] debounce, SCR: 0x100
[  189.620866][  T104] debounce, SCR: 0x100
[  189.680866][  T104] debounce, SCR: 0x100
[  189.730866][  T104] debounce, SCR: 0x100
[  189.790866][  T104] debounce, SCR: 0x100
[  189.850866][  T104] debounce, SCR: 0x100
[  189.910866][  T104] debounce, SCR: 0x100
[  189.960866][  T104] debounce, SCR: 0x100
[  190.010869][  T104] debounce, SCR: 0x100
[  190.070866][  T104] debounce, SCR: 0x100
[  190.130866][  T104] debounce, SCR: 0x100
[  190.180866][  T104] debounce, SCR: 0x100
[  190.240866][  T104] debounce, SCR: 0x100
[  190.290866][  T104] debounce, SCR: 0x101
[  190.350866][  T104] debounce, SCR: 0x100
[  190.400866][  T104] debounce, SCR: 0x100
[  190.450866][  T104] debounce, SCR: 0x100
[  190.500865][  T104] debounce, SCR: 0x100
[  190.550866][  T104] debounce, SCR: 0x101
[  190.610866][  T104] debounce, SCR: 0x100
[  190.670866][  T104] debounce, SCR: 0x100
[  190.730866][  T104] debounce, SCR: 0x100
[  190.790866][  T104] debounce, SCR: 0x100
[  190.850866][  T104] debounce, SCR: 0x100
[  190.900866][  T104] debounce, SCR: 0x100
[  190.960865][  T104] debounce, SCR: 0x101
[  190.964803][  T104] debounce, loop end with timeout
[  190.968740][  T104] resume, sata_link_debounce check failed
[  190.973640][  T104] hardreset, sata_link_resume check failed
[  190.984916][  T104] ata2: COMRESET failed (errno=-32)

Then it repeats...
Shorter timouts have mostly the same results. It never changes to anything other 
than 0x100, 0x101 or 0x0.
When I connect the laptop HDD I get this:

[  453.239378][  T104] resume, do loop
[  453.450866][  T104] resume, after do loop
[  453.500866][  T104] debounce, SCR: 0x123
[  453.560866][  T104] debounce, SCR: 0x123
... same line repeats a lot ...
[  458.450866][  T104] debounce, SCR: 0x123
[  458.510866][  T104] debounce, SCR: 0x123
[  458.514804][  T104] resume, return at end of function
[  458.518741][  T104] hardreset, Offline=>Online
[  458.528273][  T104] hardreset, sata_pmp_supported, before check_ready
[  458.534747][  T104] [104] libata:ata_port_classify:344: ata2: found ata 
device by sig
[  458.720868][  T104] [104] libata:ata_port_classify:344: ata2: found ata 
device by sig
[  458.728734][  T104] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  459.044097][  T104] [104] libata:ata_dev_configure:2596: ata2.00: 
ata_dev_configure: cfg 49:2f00 82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 
88:007f
[  459.057814][  T104] [104] libata:ata_dump_id:1363: ata2.00: 49==0x2f00 
53==0x0007  63==0x0407  64==0x0003  75==0x001f
[  459.057814][  T104] 80==0x01f0  81==0x0029  82==0x346b  83==0x7d09 
84==0x6123
[  459.057814][  T104] 88==0x007f  93==0x0000
[  459.079904][  T104] ata2.00: ATA-8: ST9500325AS, 0001SDM1, max UDMA/133
[  459.086551][  T104] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 
32)
[  459.093816][  T104] [104] libata:ata_dev_set_xfermode:4305: ata2.00: set 
features - xfer mode
[  459.104657][  T104] [104] libata:ata_dev_configure:2596: ata2.00: 
ata_dev_configure: cfg 49:2f00 82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 
88:407f
[  459.118372][  T104] [104] libata:ata_dump_id:1363: ata2.00: 49==0x2f00 
53==0x0007  63==0x0007  64==0x0003  75==0x001f
[  459.118372][  T104] 80==0x01f0  81==0x0029  82==0x346b  83==0x7d09 
84==0x6123
[  459.118372][  T104] 88==0x407f  93==0x0000
[  459.140464][  T104] [104] libata:ata_dev_set_mode:3344: ata2.00: 
xfer_shift=12, xfer_mode=0x46
[  459.149116][  T104] ata2.00: configured for UDMA/133
[  459.154268][   T82] scsi 1:0:0:0: Direct-Access     ATA      ST9500325AS 
SDM1 PQ: 0 ANSI: 5

Can it be a hardware init / setup problem? In the Armada 38x Functional 
Specifications there is a chapter about "Amplitude and Pre-emphasize level" at 
the end of SATA.

Marius Dinu 


