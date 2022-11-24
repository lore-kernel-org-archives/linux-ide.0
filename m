Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B8EC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 24 Nov 2022 02:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiKXCkg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKXCkf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2022 21:40:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16439627EC
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2022 18:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669257633; x=1700793633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c2xNc/sdomk1OXvj8lHx/r2KHeoa9QsKRHCbEHtNpKU=;
  b=IdZwE8QN0sbBpxEQ8KbfCfs/IfhNaKrHh3ymouu5gBVihteFFCkjSBrT
   UcwKVqgQ2Zjk3hLBIV5RenEZWcBAdBOne2yUlDq2mNmd9zkp0g85zatv3
   wVdhbpbchOLyv0JGV81uo12H5OLX+CYMDLGORYVTwlyKMMJOWev7uXhAd
   3b+dBObPMaXmd8QrYUW9OXirWa02GG6a5s84f4S1fra/uCchWY4o7i9f2
   x5PFB6c58nJzPCBXDEew/DeGNK0vp0wN5Jeln/ex+oks1S2DJxRQbtoXT
   emYJiM9seJJ04pnNvBV2iHOGGD4BaWvVqBbRmu/0rXE4Dd2iTmkgT3DU8
   A==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="215295556"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 10:40:33 +0800
IronPort-SDR: FWIYTn3ahL6XayiYSN84wcSQRoiQ/uD+NOQduwPsi7KcRG2TNd6YbgNSsIRcmpWAGf4P2VMjD3
 6aOHlmBmL01NvgEbsIyQ+lARNfmnMRif0LFZIzE+nluwrYqPeCw9k425py86xXXjXhGzQIE0F9
 1cn2E/q/DG/0LJs+rmsL86QY7hkhL6zHIG94rHeyj+TnXnQVOu/9Xo60sDHxP3vsyIJoJiFFqR
 xupK0Q73reXfI/8XlfXJIL5skJdJT8cKHvEsQ+FiqZxzC++CWN8YBTmkhFTTdxicJ6PZAy2P+o
 Paw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:59:20 -0800
IronPort-SDR: W61TViM+ZP6IF6cy4OScQgqnsTy+8g9Ly0bKe0Fd7zXbstFhapzkqMeSC7ZQT9SbPk1QptOF4v
 hZHhWg3oogU9Q55/VGxQcpV4zhXWj+xFW2IJ3t/4S2VrZadnmjHquIDSDxnVh2sZXGa4v7cWPL
 PBquujn7hFvaYCl8u+tN1pJMGOQBldJuyW9fpkCag68C8A+xMoBOWvu9D/d0krwHrJOOc2HvBv
 nWZONXnwV71n+AgPShWoMXwxSFq3ZzK2+FB4tpLTOrPE3Joht+h0q+yyLJiZi8RLOiit/E2m9d
 dAA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 18:40:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHj0K37DKz1RvTr
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2022 18:40:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669257633; x=1671849634; bh=c2xNc/sdomk1OXvj8lHx/r2KHeoa9QsKRHC
        bEHtNpKU=; b=P6S2J//X5nLk0kJRjzB+ni0MuVd9v1rytBA4xbo5zt+ds/RBcr2
        u4VcA/lyydYV0ryMigi+c7hZX53ZWyQl7b8nbeft5fd8vkL9J/XsBIGL3T3f27x0
        m/RQLBeUzjvDsh+OkYcSSHN2BuZCfoDCtwDSjLIYU2u2wJvtR9IncaDDZNmVRnen
        vnGJoYxq9B7fGfqYakrCUJK6TXoXbN8cVcrJ3tnVtlWrYZxEsYhSgpkkSEorEqVo
        4sd90xjCv8EMrIFNJDUr1/T/MbDoaYUIEjjp4+eKM2eJm6DU0fXwlc3kbg4wmXe2
        1tkjGtUDf3uogwmjm1sudHYnxjKNI15mHAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YfU3QWO6YzkL for <linux-ide@vger.kernel.org>;
        Wed, 23 Nov 2022 18:40:33 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHj0J4QY1z1RvLy;
        Wed, 23 Nov 2022 18:40:32 -0800 (PST)
Message-ID: <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
Date:   Thu, 24 Nov 2022 11:40:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
To:     Dinu Marius <marius@psihoexpert.ro>
Cc:     linux-ide@vger.kernel.org
References: <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
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
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/19/22 03:24, Dinu Marius wrote:
> I checked the cable and connections. Everything looks OK. The cable is ~ 40cm 
> long.
> 
> I made these timeout changes:
> 
> const unsigned long sata_deb_timing_normal[]  = {   5,  1000, 20000 };
> const unsigned long sata_deb_timing_hotplug[]  = {  25,  5000, 20000 };
> 
> And I have these results:
> 
> [  180.907460][  T104] hardreset, Online=>Offline
> [  180.912991][  T104] resume, do loop
> [  181.140866][  T104] resume, after do loop
> [  181.200866][  T104] debounce, SCR: 0x100
> [  181.250866][  T104] debounce, SCR: 0x101
[...]
> [  190.960865][  T104] debounce, SCR: 0x101
> [  190.964803][  T104] debounce, loop end with timeout
> [  190.968740][  T104] resume, sata_link_debounce check failed
> [  190.973640][  T104] hardreset, sata_link_resume check failed
> [  190.984916][  T104] ata2: COMRESET failed (errno=-32)
> 
> Then it repeats...
> Shorter timouts have mostly the same results. It never changes to anything other 
> than 0x100, 0x101 or 0x0.

So the hardware is failing to detect the device presence. No clue why.
Only an ATA bus trace could tell us more here (do you have an ATA bus
analyzer around ?).

So options are:
1) Involve the router vendor and/or SoC vendor to see if they can help.
2) Use UDB connection between your router & drive box ? (if you can)

Another thing is: Did you try earlier kernel versions ? Any earlier kernel
working ? (I forgot if that is the case). If yes, then we should be able
to figure out the change that broke the driver (which may be something
changed in the SoC support rather than the mvebu driver itself).
gi-bisect will likely not be of any help given that you are not getting a
crash. So you will need to try out different kernel versions, starting
with LTS kernels, and refine (use Linus tags, including RCs, to find the
last working kernel). That may take some time, but will likely narrow down
the search for fixing this (if that is possible given the hardware setup
you have).

> When I connect the laptop HDD I get this:
> 
> [  453.239378][  T104] resume, do loop
> [  453.450866][  T104] resume, after do loop
> [  453.500866][  T104] debounce, SCR: 0x123
> [  453.560866][  T104] debounce, SCR: 0x123
> ... same line repeats a lot ...
> [  458.450866][  T104] debounce, SCR: 0x123
> [  458.510866][  T104] debounce, SCR: 0x123
> [  458.514804][  T104] resume, return at end of function
> [  458.518741][  T104] hardreset, Offline=>Online
> [  458.528273][  T104] hardreset, sata_pmp_supported, before check_ready
> [  458.534747][  T104] [104] libata:ata_port_classify:344: ata2: found ata 
> device by sig
> [  458.720868][  T104] [104] libata:ata_port_classify:344: ata2: found ata 
> device by sig
> [  458.728734][  T104] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  459.044097][  T104] [104] libata:ata_dev_configure:2596: ata2.00: 
> ata_dev_configure: cfg 49:2f00 82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 
> 88:007f
> [  459.057814][  T104] [104] libata:ata_dump_id:1363: ata2.00: 49==0x2f00 
> 53==0x0007  63==0x0407  64==0x0003  75==0x001f
> [  459.057814][  T104] 80==0x01f0  81==0x0029  82==0x346b  83==0x7d09 
> 84==0x6123
> [  459.057814][  T104] 88==0x007f  93==0x0000
> [  459.079904][  T104] ata2.00: ATA-8: ST9500325AS, 0001SDM1, max UDMA/133
> [  459.086551][  T104] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 
> 32)
> [  459.093816][  T104] [104] libata:ata_dev_set_xfermode:4305: ata2.00: set 
> features - xfer mode
> [  459.104657][  T104] [104] libata:ata_dev_configure:2596: ata2.00: 
> ata_dev_configure: cfg 49:2f00 82:346b 83:7d09 84:6123 85:3469 86:bc09 87:6123 
> 88:407f
> [  459.118372][  T104] [104] libata:ata_dump_id:1363: ata2.00: 49==0x2f00 
> 53==0x0007  63==0x0007  64==0x0003  75==0x001f
> [  459.118372][  T104] 80==0x01f0  81==0x0029  82==0x346b  83==0x7d09 
> 84==0x6123
> [  459.118372][  T104] 88==0x407f  93==0x0000
> [  459.140464][  T104] [104] libata:ata_dev_set_mode:3344: ata2.00: 
> xfer_shift=12, xfer_mode=0x46
> [  459.149116][  T104] ata2.00: configured for UDMA/133
> [  459.154268][   T82] scsi 1:0:0:0: Direct-Access     ATA      ST9500325AS 
> SDM1 PQ: 0 ANSI: 5
> 
> Can it be a hardware init / setup problem? In the Armada 38x Functional 
> Specifications there is a chapter about "Amplitude and Pre-emphasize level" at 
> the end of SATA.

It could be. See above about searching for a working kernel version, if
there is one.

> 
> Marius Dinu 
> 
> 

-- 
Damien Le Moal
Western Digital Research

