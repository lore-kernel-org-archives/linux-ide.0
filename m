Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2660BC46467
	for <linux-ide@archiver.kernel.org>; Sun, 15 Jan 2023 23:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjAOXh5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjAOXh4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jan 2023 18:37:56 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3621C141
        for <linux-ide@vger.kernel.org>; Sun, 15 Jan 2023 15:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673825874; x=1705361874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F9nqOobmju9QJ4LuOcGvajbag0rxkKbRpuKoNTFvCKA=;
  b=bTydlU9QawmCGbmi4DS0lBnWutM058h87UIaW4CsJbfho5CYSe6LLUIk
   vW1Ssfs77aP7zZ0lCcvoD2sKNV8e1lq6dbbJYIKy/RKO0HOveg/wd0QKd
   V4rxvHo8mcapg3qmC1yiQZqPh41Z9rDBAyL8Ltq+A43VgVhOk2xFKsYs7
   LUo4x81k2tbzlHUdG+1B6qujvcwGe6TrDxL7wO3ekpCENx3afCU0Jz8N1
   gu68Giepi/fJtkOMxvawEvzxspmZLYEJcmIpcTCBrAcuwck6VbezyT//e
   sxtWTmJJLzp1HXRA7Gb0sjfy1VSxBwgVwN1J+1fNz3CvCSyxLEXgU0Nlk
   g==;
X-IronPort-AV: E=Sophos;i="5.97,219,1669046400"; 
   d="scan'208";a="332872871"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 07:37:54 +0800
IronPort-SDR: 2RN/9hmJQyb4cXrQYDnU/Ie+GD2MsxsCc7GOOJWURdqlqUATT94Qxd+GPjaGTq80YWvYvU/zPW
 hES+zKpPUUas1cs1UcviBB22VI3Inp85iIZjWojOw4KhywI3ghUm76wKm6WtITb45+bQT74LLK
 OGqO+df690U5pv6nq9Tzo/L/T9qqhJ0megjLHOYG0udHE8aeieFVyS5tmKZDBqINbnXZGHl4YS
 6xTFBLNgIf/e1h7v9zx1+OnwNwpHRxJW1pCQM7cvx027y5TCWiXSV//dd4Medrs00E4o9e8BGW
 fRg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2023 14:49:52 -0800
IronPort-SDR: E9B4cD2ESe0LTcrXh+udwQD+szgswY9ZkrTZbYmUVzQoH9ZauZnPF0a2uLzKBEAQCLeThPwNBL
 /wPuTGr+Zmpky9GvVPczyQ+Bz3K91UehsKSkocVmvJn3ABBpGwjVdzB6G12r24T38VeAtRW40y
 emdWw+LpN1S8I62l/+m2i3vbRjADcWDTN1mYqMe0oFSF18FtHMekAw+Zosy2uEGf7s2IQoK31r
 cOU+MuUF03wtfei2Jo35d4ugpQ3AFMrFzJJcWOtK4ZRb9X7ZFojuOTwlx/K3D1LkuGfdINm2n3
 qsM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2023 15:37:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NwBR55s2Dz1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 15 Jan 2023 15:37:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673825873; x=1676417874; bh=F9nqOobmju9QJ4LuOcGvajbag0rxkKbRpuK
        oNTFvCKA=; b=VgNOVs7lLQwbbpWHjikutKnZLyiBhoO6J4Nl7kn8VxxU6NsfsNf
        uXGwu2K5J0wzpha8wuusI/ak+fzLnvkwcZ7/dGN0NfrwLqBabsLAGrWi7AjW9sPY
        Cw/VsS4oQwaEKF7WgPCAetiNxxTFryL0WK2NVj4jVCQvXxQje9Na07qM3OxNJ7B1
        PKY3sjG21r34CXwTDT8hcR/Ixt62XGgG8/JlUEMCV2N+/BSi9W2SJ2m7pF1/5S8j
        OZ7k2iHFUpToGyn2HbwI2XKcbegeIxQtEcXGyqbPXWcFX5tuATXN3568XmfdVpaS
        e7IAo9AS3BU9zk6uMxAaZykySvN9jGszf7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MuCYsXIiY45T for <linux-ide@vger.kernel.org>;
        Sun, 15 Jan 2023 15:37:53 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NwBR44X35z1RvLy;
        Sun, 15 Jan 2023 15:37:52 -0800 (PST)
Message-ID: <45071fcf-99a4-e433-f603-1ed63452b4f2@opensource.wdc.com>
Date:   Mon, 16 Jan 2023 08:37:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <b6d818c162b14cc508f5cdb14c6e88a9@psihoexpert.ro>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/15/23 03:01, marius@psihoexpert.ro wrote:
> Do you need any more tests?

Sorry for the late followup. I have been busy with many different things.
Let me try to patch something for you to test.

> 
> 
> December 9, 2022 8:30 PM, marius@psihoexpert.ro wrote:
> 
>> December 9, 2022 11:28 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
>>
>>>> [ 19.006105][ T113] Reconfig spd
>>>
>>> Which function did you add this message to ?
>>
>> sata_link_hardreset(), inside if(sata_set_spd_needed(link)){} condition,
>> but I replaced it with detailed debug inside sata_set_spd_needed() and ___sata_set_spd_needed()
>>
>> I ran the tests again with the new debug messages.
>> These are kernel boot logs with eSATA cable already connected.
>> I selected only the interesting lines to make it easy to read.
>>
>> ---- force 1.5Gbps ----
>>
>> [ 4.362670][ T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform
>> mode
>> [ 4.372489][ T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
>> [ 4.501238][ T1] ata1: SCR_CONTROL = 0x0
>> [ 4.505468][ T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 42
>> [ 4.514123][ T1] ata2: SCR_CONTROL = 0x0
>> [ 4.518345][ T1] ata2: FORCE: PHY spd limit set to 1.5Gbps
>> [ 4.524121][ T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 42
>> [ 4.533000][ T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f10a8000.sata'
>> [ 4.533531][ T107] hardreset, Online=>Offline
>> [ 4.541075][ T107] sata_set_spd_needed, scontrol=0x0
>> [ 4.545587][ T107] __sata_set_spd_needed, initial limit=0xFFFFFFFF
>> [ 4.559662][ T107] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
>> [ 4.559667][ T107] __sata_set_spd_needed, target=0x0
>> [ 4.559671][ T107] __sata_set_spd_needed, spd=0x0
>> [ 4.559675][ T107] __sata_set_spd_needed, final *scontrol=0x0
>> [ 4.560898][ T107] resume, do loop
>> [ 4.571158][ T112] hardreset, Online=>Offline
>> [ 4.582480][ T112] sata_set_spd_needed, scontrol=0x0
>> [ 4.593173][ T112] __sata_set_spd_needed, initial limit=0x1
>> [ 4.601251][ T112] __sata_set_spd_needed, corrected limit=0x1
>> [ 4.611322][ T112] __sata_set_spd_needed, target=0x1
>> [ 4.627598][ T112] __sata_set_spd_needed, spd=0x0
>> [ 4.627602][ T112] __sata_set_spd_needed, final *scontrol=0x10
>> [ 4.627608][ T112] __sata_set_spd_needed, initial limit=0x1 <--- why does it run twice?
>> [ 4.627611][ T112] __sata_set_spd_needed, corrected limit=0x1
>> [ 4.627615][ T112] __sata_set_spd_needed, target=0x1
>> [ 4.627619][ T112] __sata_set_spd_needed, spd=0x0
>> [ 4.627622][ T112] __sata_set_spd_needed, final *scontrol=0x314
>> [ 4.628702][ T112] resume, do loop
>> [ 4.794479][ T107] resume, after do loop
>> [ 4.800859][ T107] debounce, SCR=0x0 <---- T107 is probably ata1, not connected
>> [ 4.805936][ T107] debounce, SCR=0x0
>> [ 4.814690][ T107] debounce, SCR=0x0
>> [ 4.822841][ T107] debounce, SCR=0x0
>> [ 4.836237][ T107] debounce, SCR=0x0
>> [ 4.845368][ T107] debounce, SCR=0x0
>> [ 4.855008][ T107] debounce, SCR=0x0
>> [ 4.864502][ T112] resume, after do loop
>> [ 4.869198][ T107] debounce, SCR=0x0
>> [ 4.877867][ T112] debounce, SCR=0x113 <---- T112 is probably ata2, link detected
>> [ 4.886183][ T107] debounce, SCR=0x0
>> [ 4.894861][ T107] resume, return at end of function
>> [ 4.903009][ T107] hardreset, ata_phys_link_offline check failed
>> [ 4.913867][ T107] ata1: SATA link down (SStatus 0 SControl 300)
>> [ 4.924894][ T112] debounce, SCR=0x113
>> ...
>> [ 5.867867][ T112] ata2.00: SCR_CONTROL = 0x300
>> [ 5.872520][ T112] ata2.00: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.883284][ T112] ata2.01: SCR_CONTROL = 0x300
>> [ 5.887960][ T112] ata2.01: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.888111][ T112] ata2.02: SCR_CONTROL = 0x300
>> [ 5.901206][ T112] ata2.02: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.919553][ T112] ata2.03: SCR_CONTROL = 0x300
>> [ 5.930054][ T112] ata2.03: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.956888][ T112] ata2.04: SCR_CONTROL = 0x300
>> [ 5.968103][ T112] ata2.04: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.984053][ T112] ata2.05: SCR_CONTROL = 0x300
>> [ 5.988735][ T112] ata2.05: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.988858][ T112] ata2.06: SCR_CONTROL = 0x300
>> [ 5.988865][ T112] ata2.06: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.988947][ T112] ata2.07: SCR_CONTROL = 0x300
>> [ 5.988953][ T112] ata2.07: FORCE: PHY spd limit set to 1.5Gbps
>> [ 5.997728][ T112] ata2.00: hard resetting link
>> [ 6.008378][ T112] hardreset, Online=>Offline
>> [ 6.025110][ T112] sata_set_spd_needed, scontrol=0x300
>> [ 6.039361][ T112] __sata_set_spd_needed, initial limit=0x1
>> [ 6.049281][ T112] __sata_set_spd_needed, corrected limit=0x1
>> [ 6.064930][ T112] __sata_set_spd_needed, target=0x1
>> [ 6.064935][ T112] __sata_set_spd_needed, spd=0x0
>> [ 6.064939][ T112] __sata_set_spd_needed, final *scontrol=0x310
>> [ 6.097506][ T112] __sata_set_spd_needed, initial limit=0x1
>> [ 6.108372][ T112] __sata_set_spd_needed, corrected limit=0x1
>> [ 6.118892][ T112] __sata_set_spd_needed, target=0x1
>> [ 6.118897][ T112] __sata_set_spd_needed, spd=0x0
>> [ 6.129664][ T112] __sata_set_spd_needed, final *scontrol=0x310
>> [ 6.153117][ T112] resume, do loop
>> [ 6.387397][ T112] resume, after do loop
>> [ 6.394052][ T112] debounce, SCR=0x123
>> [ 6.414455][ T112] debounce, SCR=0x123
>> [ 6.427772][ T112] debounce, SCR=0x123
>> [ 6.436940][ T112] debounce, SCR=0x123
>> [ 6.446566][ T112] debounce, SCR=0x123
>> [ 6.456201][ T112] debounce, SCR=0x123
>> [ 6.461379][ T112] debounce, SCR=0x123
>> [ 6.470664][ T112] debounce, SCR=0x123
>> [ 6.494546][ T112] debounce, SCR=0x123
>> [ 6.497712][ T112] resume, return at end of function
>> [ 6.512188][ T112] hardreset, Offline=>Online
>> [ 6.527056][ T112] hardreset, after check_ready
>> [ 6.538540][ T112] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>
>> ---- force 3.0Gbps ----
>>
>> [ 4.364181][ T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform
>> mode
>> [ 4.374001][ T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
>> [ 4.501990][ T1] ata1: SCR_CONTROL = 0x0
>> [ 4.506221][ T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 42
>> [ 4.514896][ T1] ata2: SCR_CONTROL = 0x0
>> [ 4.519102][ T1] ata2: FORCE: PHY spd limit set to 3.0Gbps
>> [ 4.524894][ T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 42
>> [ 4.533679][ T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f10a8000.sata'
>> [ 4.541836][ T1] bus: 'platform': really_probe: bound device f10a8000.sata to driver ahci-mvebu
>> [ 4.544628][ T107] hardreset, Online=>Offline
>> [ 4.550844][ T107] sata_set_spd_needed, scontrol=0x0
>> [ 4.555435][ T107] __sata_set_spd_needed, initial limit=0xFFFFFFFF
>> [ 4.565341][ T107] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
>> [ 4.576197][ T107] __sata_set_spd_needed, target=0x0
>> [ 4.576202][ T107] __sata_set_spd_needed, spd=0x0
>> [ 4.576206][ T107] __sata_set_spd_needed, final *scontrol=0x0
>> [ 4.590311][ T107] resume, do loop
>> [ 4.598257][ T112] hardreset, Online=>Offline
>> [ 4.615265][ T112] sata_set_spd_needed, scontrol=0x0
>> [ 4.629198][ T112] __sata_set_spd_needed, initial limit=0x3
>> [ 4.640664][ T112] __sata_set_spd_needed, corrected limit=0x3
>> [ 4.640668][ T112] __sata_set_spd_needed, target=0x2
>> [ 4.640672][ T112] __sata_set_spd_needed, spd=0x0
>> [ 4.652837][ T112] __sata_set_spd_needed, final *scontrol=0x20
>> [ 4.663171][ T112] __sata_set_spd_needed, initial limit=0x3
>> [ 4.674127][ T112] __sata_set_spd_needed, corrected limit=0x3
>> [ 4.687268][ T112] __sata_set_spd_needed, target=0x2
>> [ 4.687273][ T112] __sata_set_spd_needed, spd=0x0
>> [ 4.687277][ T112] __sata_set_spd_needed, final *scontrol=0x324
>> [ 4.688355][ T112] resume, do loop
>> [ 4.824481][ T107] resume, after do loop
>> [ 4.833744][ T107] debounce, SCR=0x0
>> ...
>> [ 4.916944][ T107] debounce, SCR=0x0
>> [ 4.924448][ T112] resume, after do loop
>> [ 4.930813][ T107] debounce, SCR=0x0
>> [ 4.940447][ T107] resume, return at end of function
>> [ 4.948608][ T107] hardreset, ata_phys_link_offline check failed
>> [ 4.958306][ T107] ata1: SATA link down (SStatus 0 SControl 300)
>> [ 4.958766][ T112] debounce, SCR=0x100
>> [ 4.974540][ T112] debounce, SCR=0x100
>> [ 4.984450][ T112] debounce, SCR=0x100
>> [ 4.998528][ T112] debounce, SCR=0x100
>> [ 5.006870][ T112] debounce, SCR=0x101
>> [ 5.016032][ T112] debounce, SCR=0x100
>>
>> ---- nolpm ----
>>
>> [ 4.364384][ T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl platform
>> mode
>> [ 4.374205][ T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
>> [ 4.502855][ T1] ata1: SCR_CONTROL = 0x0
>> [ 4.507087][ T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x100 irq 42
>> [ 4.515761][ T1] ata2: SCR_CONTROL = 0x0
>> [ 4.519968][ T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9fff] port 0x180 irq 42
>> [ 4.528704][ T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f10a8000.sata'
>> [ 4.536860][ T1] bus: 'platform': really_probe: bound device f10a8000.sata to driver ahci-mvebu
>> [ 4.544628][ T107] hardreset, Online=>Offline
>> [ 4.545867][ T107] sata_set_spd_needed, scontrol=0x0
>> [ 4.550348][ T107] __sata_set_spd_needed, initial limit=0xFFFFFFFF
>> [ 4.560435][ T107] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
>> [ 4.571308][ T107] __sata_set_spd_needed, target=0x0
>> [ 4.583386][ T107] __sata_set_spd_needed, spd=0x0
>> [ 4.599648][ T107] __sata_set_spd_needed, final *scontrol=0x0
>> [ 4.615974][ T107] resume, do loop
>> [ 4.627876][ T112] hardreset, Online=>Offline
>> [ 4.638396][ T112] sata_set_spd_needed, scontrol=0x0
>> [ 4.647521][ T112] __sata_set_spd_needed, initial limit=0xFFFFFFFF
>> [ 4.660915][ T112] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
>> [ 4.673702][ T112] __sata_set_spd_needed, target=0x0
>> [ 4.686663][ T112] __sata_set_spd_needed, spd=0x0
>> [ 4.686668][ T112] __sata_set_spd_needed, final *scontrol=0x0
>> [ 4.688105][ T112] resume, do loop
>> [ 4.854467][ T107] resume, after do loop
>> [ 4.863650][ T107] debounce, SCR=0x0
>> [ 4.873874][ T107] debounce, SCR=0x0
>> [ 4.882559][ T107] debounce, SCR=0x0
>> [ 4.891306][ T107] debounce, SCR=0x0
>> [ 4.901119][ T107] debounce, SCR=0x0
>> [ 4.910367][ T107] debounce, SCR=0x0
>> [ 4.915322][ T112] resume, after do loop
>> [ 4.920379][ T107] debounce, SCR=0x0
>> [ 4.927643][ T112] debounce, SCR=0x100
>> [ 4.936031][ T107] debounce, SCR=0x0
>> [ 4.944728][ T112] debounce, SCR=0x100
>> [ 4.953532][ T107] debounce, SCR=0x0
>> [ 4.962475][ T107] resume, return at end of function
>> [ 4.970650][ T107] hardreset, ata_phys_link_offline check failed
>> [ 4.980376][ T107] ata1: SATA link down (SStatus 0 SControl 300)
>> [ 4.991536][ T112] debounce, SCR=0x100
>> [ 5.007097][ T112] debounce, SCR=0x100
>> [ 5.016660][ T112] debounce, SCR=0x100
>> [ 5.025693][ T112] debounce, SCR=0x100
>> [ 5.030094][ T112] resume, return at end of function
>> [ 5.033962][ T112] hardreset, ata_phys_link_offline check failed
>> [ 5.043999][ T112] ata2: SATA link down (SStatus 101 SControl 300)
>> [ 5.054652][ T112] hardreset, Online=>Offline
>> [ 5.067061][ T112] sata_set_spd_needed, scontrol=0x300
>> [ 5.067066][ T112] __sata_set_spd_needed, initial limit=0xFFFFFFFF
>> [ 5.076006][ T112] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
>> [ 5.076010][ T112] __sata_set_spd_needed, target=0x0
>> [ 5.076014][ T112] __sata_set_spd_needed, spd=0x0
>> [ 5.076018][ T112] __sata_set_spd_needed, final *scontrol=0x300
>> [ 5.077276][ T112] resume, do loop
>> [ 5.314471][ T112] resume, after do loop
>> [ 5.364488][ T112] debounce, SCR=0x100
>> ... and doesn't work.
>>
>> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

