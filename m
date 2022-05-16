Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F70C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 16 May 2022 11:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiEPL33 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 May 2022 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiEPL32 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2022 07:29:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F3DE8E
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2022 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652700567; x=1684236567;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=876yzZj6/+tm4YDmqPDxaGjV1EdwMr9TQE1q9RywbHg=;
  b=QXI31Ch+yQWa37Nv24eZzPOwgd2jTFLdefbq13+nrNY6rTK8MDYsFaaD
   O2dOWw3JkpY4zKpadag4uABHthtrRCJAK/C0325Uu0IgyFvxJRpM3Nc0b
   DBQ5HBdbDAMVhGxJEjKKmHZ5RKRVSMJza64rQQwsMhx6CqIZIDN5VHbGB
   jiB0BvLjhHrc0XSe8P02EUWZu6vpv14blZxzTx9O2C1TX5Bcvw/WJbH1N
   WZHzfKtitNCXOkOzQ04RfIFkaSgdhgGHcgAq0vtICvJO0kkm5ifJejbC+
   FmzOKV64HugKNT7pO0n4E1aq1kXm8bz/R2r0ZOLiRRGDNxg8ZBOAc+KNM
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="312408658"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 19:29:27 +0800
IronPort-SDR: Tf6M/yVyNwiwxOGBhf0Dz6z4KRVw9CSYYAtrRut7BDdZ5nlU/6tuoOI/snJICQN+rX3oxniNTP
 HJN2aSCT8k7FikbWgVXvt+URl3ut/6Idc+sguhi8SufJ1CHQnTUuaGYFsBvvqm8JFMC+EQAcag
 IRPzETw0CGF7jGUCYd/sYCCA3ob4jIppv32otsDHeMLYValox6lhe6FNRQxepkxjY9ONxsJVAD
 XVzoGUh3uzHmxrn0OlUv2hez+cDpl8Pd/gSMePzuTRF/FaJ1HJAqll2czjzoc0gnxglFSTZLTe
 H+X5+gc+3sjL0Xt3ogec5G18
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 03:53:20 -0700
IronPort-SDR: qG8FgwootM/Ojk+lbBA/HNnJyF0uofR3HgCCGQ6ginPHQ+zgknGVN/z3nDGGAwTNoKDgWYt7Wv
 i5CPaNlItN339mm+R8hznb3luuhe1i5uGmQiW/kwWzEJ7PrE57kfhWPff2rSFL+NEOkXl/w5f5
 swUa4qPvK5Igg4tJLqHePlgsoPskiiBjsMQ87Rgri3iEpqOALmUxjxSpOOtej5no/s9gnpzUTD
 kz3B4B3C2ZEcyVQni6iCAkc5yLMZB//0aMEJ44cf2CPkdziq7AJfMRQCf//vALkza+FKNlY795
 h8g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 04:29:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L1xqC31fdz1Rvlx
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2022 04:29:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652700567; x=1655292568; bh=876yzZj6/+tm4YDmqPDxaGjV1EdwMr9TQE1
        q9RywbHg=; b=ZLhse1cPwPHAoN+s49KmgqCRpnU2sLsxn+Flws1fB5S0FtlefPK
        oEE7MmaG+Z+t0JjVwdi2a4lk55RBef2H8ZINLwhOPv8gBz377Ko19vCE2RKIZSUD
        Q8/6qrz/TxtWTS2Y7WKYTTZHE1QTBI3v4dg8Qu9Rw4uJs5DO3OQEzRHnk8Y16efY
        yotbN8HgpstsCWRJWXHkgWPUvdg2SNAoxQXtaJ1ierjFBBFmznBQvzFah/XitAs5
        MuouZC4uq9ohLJyJhg3MOOFTE3+ihqpbB7av5pIiiphfVjeQfEAihJ6jb132tGT7
        P+5hrOJfMU3n7udh3ASXjDKsd1mWihg6zpA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zIODr2HJJPLx for <linux-ide@vger.kernel.org>;
        Mon, 16 May 2022 04:29:27 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L1xqB40Bzz1Rvlc;
        Mon, 16 May 2022 04:29:26 -0700 (PDT)
Message-ID: <f8e5288f-e0e9-da11-6a82-6bcbe5365eea@opensource.wdc.com>
Date:   Mon, 16 May 2022 13:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: libata-core: fix sloppy typing in ata_id_n_sectors()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/13 22:50, Sergey Shtylyov wrote:
> The code multiplying the # of cylinders/heads/sectors in ata_id_n_sectors()
> to get a disk capacity implicitly uses the *int* type for that calculation
> and casting the result to 'u64' before returning ensues a sign extension.
> Explicitly casting the 'u16' typed multipliers to 'u32' results in avoiding
> a sign extension instruction and so in a more compact code...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-core.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -1107,11 +1107,13 @@ static u64 ata_id_n_sectors(const u16 *i
>  			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
>  	} else {
>  		if (ata_id_current_chs_valid(id))
> -			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
> -			       id[ATA_ID_CUR_SECTORS];
> +			return (u32)id[ATA_ID_CUR_CYLS] *
> +			       (u32)id[ATA_ID_CUR_HEADS] *
> +			       (u32)id[ATA_ID_CUR_SECTORS];
>  		else

While at it, you can drop this useless "else". The 2 else above this one are
actually also useless...

> -			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
> -			       id[ATA_ID_SECTORS];
> +			return (u32)id[ATA_ID_CYLS] *
> +			       (u32)id[ATA_ID_HEADS] *
> +			       (u32)id[ATA_ID_SECTORS];

Given that the function returns an u64, I would cast everything to u64. That
will avoid overflows too, which was possible before, eventhough no problems seem
to have been reported... Who uses CHS these days :)

>  	}
>  }
>  


-- 
Damien Le Moal
Western Digital Research
