Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA9FC4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 02:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLIC60 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 21:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLIC6Z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 21:58:25 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CAB22536
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 18:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670554703; x=1702090703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XYvY7qIrEH4KVazJqmAoNQwpNIVYhq1ENNLejGYHHnQ=;
  b=NdYv18bo8vvnlBUTKYNh8MOW+9kXLYrWzJXh+tMPg1m4ijFAq0nYt+bS
   JsY4giXu7zkY2i+//h3KJGBSsKNsrcwPE4OjV95V4VIhjvtiJZ7hz6rmQ
   dYrZ8s1Yvla3NByDoJ8NF6SDbKOR3zQAET8AW60jqZTbn8HlXaPJT3RIr
   FH0RttiOgp2dx4sppVjOJ1McmlKTPmdmtshv4RHLveMjuIvrB4BZV9baF
   o3OUO1mIh85WD3vp+iS0VuTOaXXanz/Ez4jawmvbJfdt0B+NpLbAp0RZF
   pFCs0vOt/gqsh/WhvfqtWIgQGFGOAv0DLaV0MkBGmY/JQ1e3R18QNDvxo
   A==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="223397274"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 10:58:23 +0800
IronPort-SDR: pJkVlWsCySgiJTZKKx/xG1dNtFN1qPHXGtEaGjJPB4jk9G+yWaoZuLJCpmpY5jhLE7Stjo7Wa8
 dJD5aKEqYCqsFs6GFZocfxVbqN3gUD+XIm8/bIKxk2fKZexC8Z1G/NkvUTXDZ/P1oD0SuFEQJP
 UQswz1lmlFqgeplJx71s4ZypTeD+J/O38U2bfwHWluLx5raXIRi+kwr+tq2jydR7eAKhnvs/Xf
 NYbNADmAPX9J75a+RZTYJqTJY1JDF9Sx0U7U7aInIQjVkjzlzPsNA9S+LEKaHF1UUJOIpety7Y
 IHE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 18:16:52 -0800
IronPort-SDR: HQnUgxwAj9vxYaeccgGl82lCYA/Yo+gqjaocHtmpq7m1LgdD4B4PI83IsNYyeoPQiS63y8hwG3
 /lU12F6Oyu8V07Ojhfg5msKQJPWtbQl9q68qPUHTXCIJaP7BAZH6qVlZqFnmhVBKN1EergAlIx
 Zsec5OA1/cp6eEcTDYxZtENLHjIskLeLCJT86A1X6wUnYr+4b4dzBk5FXp68Nbf18r9DA4aEtx
 tnSx/V6RsquJR6wtNBzQLIEDST1VneHfEQyrii4aDpWZcIz+ktzM4aUVi9Y5uhkTXHZugDYksP
 Nb4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 18:58:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSwgz05ggz1RvTp
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 18:58:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670554702; x=1673146703; bh=XYvY7qIrEH4KVazJqmAoNQwpNIVYhq1ENNL
        ejGYHHnQ=; b=RvAaZ7CiFcD5EX1NFL5ilK36AKPIo1uprprxUhQFlMlpDmiwQcQ
        mQ4kC/m47V0bMhZyjujnpvmvKDH1OsgnzprATceAtit3mmhSCtzSDz/MtrsIvwiA
        8GUgCh+90TR1twGa0oc+G0aeroakGRmQqk/xM+zpNOUZMSFNfo7Ke4J3RgUeIJmh
        TWdqp3Ha0bhnYGIOW57R88X4tCNhmoX4Ia9NO9BejN4gY2t51B9Np0AnCetQ9P07
        Z767vM05q3BoP7fo3zawfWf9zAFAUznS73IJZamx3k2ZoqPelINZkuDpO38fC+BI
        wJqUdcSDu54m1iTntrFXEc38GAWzPM0zfJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kTNn3dy7PZcb for <linux-ide@vger.kernel.org>;
        Thu,  8 Dec 2022 18:58:22 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSwgx6Hlfz1RvLy;
        Thu,  8 Dec 2022 18:58:21 -0800 (PST)
Message-ID: <1b1f8ab0-9a2d-93e3-66f0-18597e80b790@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 11:58:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <f030af47-8522-cdef-8394-84f020c6ddca@opensource.wdc.com>
 <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 03:06, marius@psihoexpert.ro wrote:
> December 8, 2022 12:51 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> By the way, did you also try a cold boot ? Switching off your router,
>> connect the pmp box, turn on the router ? Does it change anything ?
>> ATA hot-plugging tends to have more problems, so worth trying. The
>> ahci_mvebu driver errata is for hot-plug, so this newer SoC may have
>> different issues with that too.
> 
> Yes. No change. Same errors.
> 
>> Can you try with no patches and no revert adding the following options to
>> your kernel command line ?
>>
>> libata.force=2:3Gbps
> 
> No change. Same errors.
> 
>> libata.force=2:1.5Gbps
> 
> This one works, without any error at the beginning, unlike the way reverted commit worked.

Checking the specs for the SoC again, it does say:

Gen3 Serial ATA PHY (6 Gbps) with speed negotiation to Gen1, Gen2

So with your gen2 (3gbps) pmp box, clearly, the speed negotiation is not
working but limiting it to 1.5gbps seems ok. Could you add the following
print to see what the HW is saying it supports ?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..b3925239b8b0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5271,6 +5271,9 @@ int sata_link_init_spd(struct ata_link *link)
        if (rc)
                return rc;

+       ata_link_info(link, "SCR_CONTROL = 0x%x\n",
+                     link->saved_scontrol);
+
        spd = (link->saved_scontrol >> 4) & 0xf;
        if (spd)
                link->hw_sata_spd_limit &= (1 << spd) - 1;

-- 
Damien Le Moal
Western Digital Research

