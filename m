Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6CBC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 07:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiFQHsl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbiFQHsk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2022 03:48:40 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD5674FA
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655452126; x=1686988126;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nDh5lFWZsMx+VLgd7S4sxAT7uTU8JzbbXQedlHxFQvs=;
  b=Ck3LAlvWPvE21ENttalrVeDUeocyUAwdsGkARkm81fxlfXHFCv2AuodR
   ZdDHOg0LP/x6erR23zNCe5TOfPHMyovh03Du1QxpiU2zHSYseOS8adHs+
   ntiXsiGA6qMLU4a7tj3G+l/oiyGFRhMa9QTcaW2L79NAZDzgMNhZndDfs
   0XE6I3/6OPn/tSQOfxKlKmNy6ioqiwDNcB6qTpTri5A+o+xTXcyAF5+eB
   wXnpngcUI2wElQDFJPhavB3WHtel8NddTqd0zAVpwzbTdFz5rpUBkNIWp
   ZR9ZwpVMO0en3ZZmCPBPRJosCrTVpHKRE4GTnQGVrgtvyuPIQnXQq7QNs
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204169137"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 15:48:45 +0800
IronPort-SDR: gpRyfEh4sQuibazdlkpgRwEsTO2cdg0hugj0XnWXYcm5xQJkunC2gPCspsglZvnqAfYdzVWyQl
 Z6Eb3QhSHNcLkrrncyh7pYp+YZg1FTXp39J+S2JzZRJFZE5Yv7r4EcsCJnAt0gaxT4vN56YYuN
 KWS3kLhKzExn2GFUzU62Y+rgfdTzrZytV6xHs0DePdOerPkfb+0E1yLVvDdzg4IrXYsah123Bn
 f/QkFOKxeAZjfhJbG0C5WsT4czgm/eA9zHWYTKzdOXd72FQHS4p1mMfGpqLFxqyN0Al0QbiQC8
 EUR2iB1j3KHHiA6YVJUiG5d2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:06:51 -0700
IronPort-SDR: u8Lr7RJM8J9Ru8ebI7HvipBP8jg4EO2n9IXpK7QN3Lb3Fqb/hVg1OZkh4seNSbReO+RhVYOMpw
 k4TIqmqQF449epfpQhR2IyoJ8lfPMDI0QBwTqyrAuLCW60kYAgTtPKoTVgKkEJfrEOzVMPjY/E
 bIAb1Qq1zsJLIhZxiYCe/EMYkccSnpIiEDg3GzX+99FKBE/xxcHFPnKVFkUKRtD/W4GrrK+Z4R
 MPRq3Da41dIPqpTaQXTZkBT4NulCcDuI/+wJkpjwGGzoerk7aYkGT0INWCDaMnx9X5WFeHUrb6
 WiE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:48:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPWPg2lWwz1Rvlx
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:48:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655452119; x=1658044120; bh=nDh5lFWZsMx+VLgd7S4sxAT7uTU8JzbbXQe
        dlHxFQvs=; b=ZuPD04WvRMBrOiBI9Tl+7Ce1uDfmGmqmgTleueTqSNSDFBk6yyY
        0aW13SA3PFxxaOFMr5HyKPmFO2Urv6vYtFHRu8l+IG9ce62Q4CArjPld2JlvRPg2
        OJH/KkuRjnur1Pcduy4wOfuzW1YUZJU5ESzw8kvPHhmaO4DeOxsA0LahZO1psVBI
        FnFFDfgpD39yCNWm+5ijJEJJ27IlnkA/PY/4E767t2ZAvz4uJqxDqK7MR3KjvPU5
        ZiVjDFV3lg3J7OR9YzbqA5KM4f+M/FLKqfHkHGnBjq8IaNFOs1kkq9Y0oayfhpEV
        9gE+l5okMPVVNwhwQ/hABwpJkHoCQASr+tA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w6NNjsfONaL4 for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 00:48:39 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPWPf5W05z1Rvlc;
        Fri, 17 Jun 2022 00:48:38 -0700 (PDT)
Message-ID: <202b0ac3-eb20-9ecc-79fc-e1f21752d570@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 16:48:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Fix sloppy typing in the fast drain logic
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220616205149.16157-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616205149.16157-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/17/22 05:51, Sergey Shtylyov wrote:
> Here are 2 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo.
> The libata's fast drain logic unfortunately boasts of some sloppy typing --
> unify it by using *unsigned int* everyhere...
> 
> Sergey Shtylyov (2):
>   ata: libata-eh: fix sloppy result type of ata_eh_nr_in_flight()
>   ata: make ata_port::fastdrain_cnt *unsigned int*
> 
>  drivers/ata/libata-eh.c | 8 ++++----
>  include/linux/libata.h  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

Applied to for-5.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
