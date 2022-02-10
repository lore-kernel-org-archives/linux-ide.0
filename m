Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA414C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 03:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiBJDIq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:08:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBJDIp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 22:08:45 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 19:08:47 PST
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3831EAD1
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644462526; x=1675998526;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0rzHpnyzUkKxNN2Mid2NVGCL5C/VT9DUE+4AP7OTFG8=;
  b=DJECUkj3/HewXHvDCfs+VDHpoz2ybcnrkvzisV+P/SLdlsv2AV9xk+3+
   j+wl66/Ezcqlc1nA3ve2KoCvl+0RWC4dwuwYWaN7XhlL8yelePpmkkLTS
   8+APuaG2b31bxWjng5B0v8zIi9j3KVpNWcCGzhT3JUKnA4HXj4bFtFtlK
   j7+wmtx6BIWEFTB3fmnUzkBXFBl8r6rhjSLFKJq4/6hDE5iu3xys9jOg6
   pY9ZWhbksAdHuLINxPTisgfJftbb3N1nX/OZFIdFwUg4G0VaakbAG4iGO
   ddRXc7EqLe2wZoaK8Ugye02Ur/cmFhRr91IJfMWpYMEPr5MR0t7lCAxQF
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="296661338"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 11:07:44 +0800
IronPort-SDR: Kxp/3n8Lg+Oy5tRRiwnLl7koTnDsYtzd0+i6UFqm5UIl2GTpcCscYBGsvJDoJQ4IxoGOLOOwhP
 bIiqx+pVQrpMPAw0kC9K5nCf4NbnelhLf3sGCdAOaXRYBqvxhzHYGjH0Hd1ppdI3cIECJzs4+j
 PczHPFPyexgaSCIf8vhqQnUN2gpsLQeqrUcva0CqFQ8oLUh2ZE8WEDYtY8gGAfVrS9XwYs4XTN
 +93R5hgaDU8fwuGzLXsZ/DQW/hCaV7iA47cxiNVy8jMwHKI0xVuuxzWOA+0fammZ66kDAr8oie
 9x3iNqk8/mZ+GkE/DLGMVfRw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:40:41 -0800
IronPort-SDR: snz/8tX22nngrzELm2dfh1WbJMtEcpH9pliRUeoEaQYNzabu93PXNQLQsR1T3Xz9vArbCvlKLg
 E5lj5KtRlVLUuFYbWs5GEyn2qUmaY8LVrXoU05onkr8x6LfeIeB283lUjNphbE9h+kiwNk9igm
 6BswAgnR9uu7wike0kawzW1xcjVe1QMDHRNak2XNndTWLWWFI+RgtrdM1j0hssrxt+L6M6ZJLc
 WqGQ80SSozYr0IiuiTBFN44PtlesBDwS2gZIl2Fp/2FZe5+1sI4kVayDuE5+TIY119kAmttVo/
 Ess=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:07:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvMB75CfTz1SVnx
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 19:07:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644462463; x=1647054464; bh=0rzHpnyzUkKxNN2Mid2NVGCL5C/VT9DUE+4
        AP7OTFG8=; b=mlg2ym43DSMYdvuksjgFahTogRDP3mOshihl9BwCb0aJU4eQ88N
        vnR7VpNfcsAo4tz8uA76mKZbfQ/T8NLhF+khquUEqBgm9kXPgeDc7d/MXbMA8ifk
        bP74PfF6b3Qe2wRBV4MUfrEVZAxIpE05a85GDL5fDJcKrzvnrpi9U4d2+4cLoM++
        y0SoS1USrBMIbIQHrPghF0ZbMS4URXXQzMhHLt3S1YrD9AQocqH/Lb0EUJVa+/xN
        n0KAfMAc3TFvrbzHx2XSjGNxNTIat/cCSiLYzSCaooCwGW3L9uydYMaMFV8lWpD4
        dKH9Cr8Kus11k4n3AEF7eN7TMQEBdZtXbRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XqtLjW4ifcaw for <linux-ide@vger.kernel.org>;
        Wed,  9 Feb 2022 19:07:43 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvMB70kk1z1Rwrw;
        Wed,  9 Feb 2022 19:07:42 -0800 (PST)
Message-ID: <12a37e36-8e0d-f334-0482-2661583314b1@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 12:07:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/2] Use *switch*es instead of *if*s in the Artop PATA
 driver
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220209202535.7679-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220209202535.7679-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 05:25, Sergey Shtylyov wrote:
> Here are 3 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo. The driver abuses the strings of the *if* statements
> where a *switch* statements would fit better...
> 
> 
> Sergey Shtylyov (2):
>   ata: pata_artop: use *switch* in artop_init_one()
>   ata: pata_artop: use *switch* in atp8xx_fixup()
> 
>  drivers/ata/pata_artop.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
