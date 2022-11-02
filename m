Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4631AC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  2 Nov 2022 07:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiKBHeK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKBHeI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2022 03:34:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D161B786
        for <linux-ide@vger.kernel.org>; Wed,  2 Nov 2022 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667374448; x=1698910448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gN0he4TZL938QunkKSJatD4ko7UmrpUeuZcG3bRDpUQ=;
  b=D/vpTbeEorChl2oWCHDqg6/vVMKZ95tYe6gdJKBBzppTOIFUmJaofB6V
   uTDUGX2/q7om2NDGJ1e3aK/MJY2HvaQGoGWLUYZqKSC4Ll1uo1WFGAtpL
   A19K6pSXgnvUNmPrY4cQHR+4E7cWgI+OnUn18VPZJU3li1Pa4dqfk8f4E
   s1HSD1TIk2r43v7JN64lU28ONoqOFHJgjwPEjImhUidQiCUAZt1D5ZP1Y
   /DFB/cGS1237On5v2O4uY8VwaewKBL3Ht0RsIDNUkr0keBIwT2Y6KxGap
   j1+i2wKZooYOTmfcYxio3G9GN9acg0S4atPLqafFrRGlNNKvCDErvaV/r
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="327393872"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 15:34:08 +0800
IronPort-SDR: gV0fckfXc54L8ulmTnCSAHrpwagZmsMJbeNcK+J89/KVKR0UkyUeNIcK5p/bFzRukT77vjXe0G
 rzV1LK7cmmX2WcfqWPYbgelEUf/6T8LOWWvt91fpMayUXhUeppXZCawpAMvlJ1btD6zlXJcr3v
 UKzsUCdy1R8fQYxQdFKg5oIMJiJoDcMT2q2g+EWMXMJ/C9DNjmR4SLcEDAhNE97XthW5y837N2
 qxWmplmBT2tvhJgETmXpuIDDAjkJB7iT5ZNjCqqCVzkkVIIHZqWCtPu7gHuEkPUq2e5GAJBK4G
 gdXVXPbl7ryZZRGMWwv8ai07
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 23:53:21 -0700
IronPort-SDR: lIXr99vdSG8bqqku7LnncD35ocN9MlSfPXut/tYR5H6arfE/P9v3d1eTFeI0F77oRZUID7TGkJ
 8M0ronxuy5LW2NH/2hAPVRvfQyO8NGsZ2CvyQg3shTzJEvNA1vuMjEikrjC7HtX5gq1WOSXQYG
 T59vRBXaSekdgUQe145+FncEf02JkGUVugJeYmP3AN3bvgE/4xJ3swPvtgb9Gb7roozEItHwub
 /GBrCwJwjPQL8Ao2I6S8CUBbYa2Ntd4ApsDjUHdX8Kux8IVi0zPq7v6bzpLKEoHa/pvBh4umhR
 7fs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 00:34:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2JYC2Jsvz1RvTr
        for <linux-ide@vger.kernel.org>; Wed,  2 Nov 2022 00:34:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667374446; x=1669966447; bh=gN0he4TZL938QunkKSJatD4ko7UmrpUeuZc
        G3bRDpUQ=; b=VYeUnqnkUJ3f1IzDH3YyFtApmR8uZeVgq9y3kL/hVws6kcSxCq/
        GWTyYl0h7dinNEXS50D8r5aMRZb4I0gvjQsiL3Y7jv0bPk8j5Ya6cp+8aNfiHHCe
        82Yryvbm/I1BdKw2dvnUSf1FssQzBTQNcr0hSLWvz6Rh8dVxn/zyVkWcLVtG3Faz
        XaPu82fHYSO8Yww66pjeBQK/GEJSQL8eUOYZYvtMSwQGJWlsuoS3SQ5xnmZ+R/O2
        8Dsi9D3Jr7UHNyfGps4ROp8P914RM2fKdTXSZVhqGEdeXzvSISJHf14H+RXzEQpQ
        BBtd6M238tmmOkLRf58VtLG3uzRuzjebAiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jwuv-T9HrpEW for <linux-ide@vger.kernel.org>;
        Wed,  2 Nov 2022 00:34:06 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2JY962hkz1RvLy;
        Wed,  2 Nov 2022 00:34:05 -0700 (PDT)
Message-ID: <c48606df-7956-2a28-8114-64ab46a04d05@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 16:34:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] ata: pata_legacy: fix pdc20230_set_piomode()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
References: <99d91d0e-d3fc-5492-ddca-6da6e65e1e89@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <99d91d0e-d3fc-5492-ddca-6da6e65e1e89@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/29/22 06:07, Sergey Shtylyov wrote:
> Clang gives a warning when compiling pata_legacy.c with 'make W=1' about
> the 'rt' local variable in pdc20230_set_piomode() being set but unused.
> Quite obviously, there is an outb() call missing to write back the updated
> variable. Moreover, checking the docs by Petr Soucek revealed that bitwise
> AND should have been done with a negated timing mask and the master/slave
> timing masks were swapped while updating...
> 
> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-6.1-fixes. Thanks !

> 
> ---
>  drivers/ata/pata_legacy.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: libata/drivers/ata/pata_legacy.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_legacy.c
> +++ libata/drivers/ata/pata_legacy.c
> @@ -315,9 +315,10 @@ static void pdc20230_set_piomode(struct
>  	outb(inb(0x1F4) & 0x07, 0x1F4);
>  
>  	rt = inb(0x1F3);
> -	rt &= 0x07 << (3 * adev->devno);
> +	rt &= ~(0x07 << (3 * !adev->devno));
>  	if (pio)
> -		rt |= (1 + 3 * pio) << (3 * adev->devno);
> +		rt |= (1 + 3 * pio) << (3 * !adev->devno);
> +	outb(rt, 0x1F3);
>  
>  	udelay(100);
>  	outb(inb(0x1F2) | 0x01, 0x1F2);

-- 
Damien Le Moal
Western Digital Research

