Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BCC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 07:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiBPHUd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:20:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiBPHUd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 02:20:33 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F521E6C33
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644996015; x=1676532015;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hDLC2zRhs3FuMl0FOeYx1G2+jjP5GM+wSFQdLvlcjz0=;
  b=k5+ZBnpYUe7z7c08e6Lbb8XZ1jWV/f9E1jMf2t+By/xAI94KAJilrEAB
   LcIRePWA+gEmNo+RhdOMvPD7J3In/bFp96j8SjwHSbSljfPbFqHWEHO+t
   Cj5vGHGgykkFFTg+HWYmVqDMz4nzeU5COMMqmnm0nx0ZzLR3I4oaZSqRR
   Wy0UAGtx6OXLaoxxrJXAjFwwld2/C3ARxngF3qpEH13i5Qt9Eudi1YNQW
   OJPmTWDvHevmMK5bVQvFcQXq2E+36vowLX3Gu9ug0Q3ngewSX6gQXICcR
   VnUtZgpl5aIrDkXmSW3C0x2FKxCSfoJW4m58eqtno/ZOc93kJcHxbiU3X
   w==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="297184881"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 15:20:14 +0800
IronPort-SDR: cDufy01mqqoeCDmQG/9bGkJ6l/+MKtzz96HDmx0HyIOIQED5ClEObm4UnUpeMnBsHE1/F6bKfd
 lZOw3rMf1tFYQ1QK59aDLy3S9YkB8bi1kmQpc5uvhT/5fO2AjSfvZ7FJGuFSYXjyrzmpPWX8PU
 7Pl4jCs3yavD1ER6Ozqr+AGCh2G+tkpVULk7l7qCDo2Dk1RTa+b2tmr/QcKx6zJ6aCN1fV2A89
 gaxT0VbXXa8cLMMWAEYi8QRkPjDpXQlpQQdpfpzKYcQA0ZPv2JvCyJBeKXMuXVbEKaIxOq1CEa
 lHwSHY3/PN9WoLvIVuh79AiK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:51:55 -0800
IronPort-SDR: EFRYs3ZajkSawplRsVhlh2qXmZ1zuzVpmKhsF1DsVBTC9kqph/aI3ueG5UZ4SqJw3Djq/GEHdx
 CfYeSIUbi+eFh76m91frejETLG5U4fxT1xj2dCjwScgXK1Db6xr1ev62OBVq3Lu/19dgdxW2+Y
 CrKR1CrhyclkK3UQH30Fpip5+E/LnNYs/VT6emVzkAYG117+8ZxogLT/FW6RlJWU9AZsXUqH/P
 PSiVfPKCGQW3Rj1hrcSfpRlMA/q5EE5kiDDWs6QllqF3eGEVB4jA27pgZsNlWzSMHzKVRCCQMb
 5TI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:20:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz8Vk2qNjz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:20:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644996014; x=1647588015; bh=hDLC2zRhs3FuMl0FOeYx1G2+jjP5GM+wSFQ
        dLvlcjz0=; b=uT96XTqb2gWB2hVs6tB2JFUQ8YHq+R4x7I6CbxL2rejOQBR4w36
        Wpnse/9LyTHMsPdMuTjI+xUKJNAhgvaniu9x7ap2rlTyav5ulbpMVArYCMYArHAO
        M4xFLmNCRjUFhZJXlTwJeB+MUQdxGbWcClXUO+JS/c58H+br+OR8/0UQVLJn7mtV
        wYiJDGZHbmf5XG0iRfc0cHr0JvsLzfKspLmT35zhAEwbT36+VCpeof9OypIAR25n
        T9THKYLpXd6hxyqKwZoTHEEclYmRg0DoErqlFoE85YwLVpIF7CMSAt0dm7Ut2hSy
        SDNpYGtZxIBi/z4m9lGIirqDakYR7Mr2avA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eaiOR_QvP0bt for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 23:20:14 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz8Vj5Qd1z1Rwrw;
        Tue, 15 Feb 2022 23:20:13 -0800 (PST)
Message-ID: <e6f18dc7-35c8-1792-28c6-dc8b15181b71@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 16:20:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Refactor the accessors for the ATA device control and
 alternate status registers
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220213151032.4694-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220213151032.4694-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/14/22 00:10, Sergey Shtylyov wrote:
> Here are 2 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo. Refactor the accessors for the device control and
> alternate status registers moving the prerequeiste checks done now around
> the calls into the functionas themselves and make them return a 'bool'
> result indicating if a respective register exists or not...
> 
> Sergey Shtylyov (2):
>   ata: libata-sff: refactor ata_sff_set_devctl()
>   ata: libata-sff: refactor ata_sff_altstatus()
> 
>  drivers/ata/libata-sff.c | 86 +++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 40 deletions(-)
> 

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
