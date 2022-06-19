Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF0C43334
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jun 2022 23:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiFSXYQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jun 2022 19:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSXYP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jun 2022 19:24:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2FD64DB
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655681055; x=1687217055;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Wb8BKkCthQ9bfXwfkMt0/RVkz0PQA9lTEIe2ifk5EPk=;
  b=l/ov864sAOFPhGn8WwLqdUzxESB8rea21bhuqsgJnSPxN0xZPze2Dpu7
   kPE9n2i0FtnMDbKQlKg2r6tNxbb34gVrHhyqac4AXLyEYBbOc33tLfGXO
   0sSlY0wDhXcXgJhHAGCoXLOeTSbIHbA4Bo7ixHRcl0mClqq8MPGq+OLdZ
   mGTpRx47O3UlqTXi30tTNcXc/Be6HgWcEAXuS5kzboB8k13AL7TWTCjm7
   GqXZlGbH1cI4m+plX+Zj6ItNABsIHnRRkmpAEBckcSAsXw28bbP3bCJtO
   dBvAYLXKFWjpMRxEg+3fU0aneAbSKPEANf+D5E+BDLzmXOhsPHm9vvlpm
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204331914"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:24:14 +0800
IronPort-SDR: 3caWo/4m7bsyUkWvGq0+MdRR4h5sYSxXxzeN0FUaxCUOnJ/WIOw/KB4/TO/7Y5i6ocOZwqoKnG
 gRatVS98vYtveHZFLyLMK0AJ4ObEi6Xbyns3GWF4zAIEOqfrLvRUQtwlJicFLkc8A1rFU2epf7
 f3dPv6N+tjVF1ybGIS0cLc+wtdqd/Q7OHR0v62IM/q/byuulSebjJKy/zE3llefdMLVX3kDV3l
 pRMP+3SDIAVx02r3FY0ermmGp62NZq6VqnbhrGrrEqE0m1yPaxBia2YiOrVdm6RVbukTcn71xJ
 SM7G6TB3C+GInTi3dijggmUu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 15:42:23 -0700
IronPort-SDR: ro1vQazii8VKib1exnJhv1ypZRcPp55DYMcBniJzA3VdA9ofDa2XLNGkfjGP9kZifjA9eyQSJI
 bUZ0IXFvxrsfrMnM6HrT1mhfrnzxw5ypQt0n32i3xXx45WEMA3NcahDtsWzdXaPKo52Vb6O2/6
 Hyn9cwt24jnReOzfrgxDQgoRAU2BP67uZbT0JlJ4PFEDnDpsFuJmaEiaVwT03I4djunXs4erwx
 l7L/e9s26+GEgpPhBAOT3e+XTB0oM332ZwwARbcf5km2aWQGkW8ZGtLTZtQC3fH9lZA/am5G33
 qrw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:24:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR84G0D1Qz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:24:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655681053; x=1658273054; bh=Wb8BKkCthQ9bfXwfkMt0/RVkz0PQA9lTEIe
        2ifk5EPk=; b=N9lNBwkhfKWJgPGwuPjg8h3CO2rp9ewXLOJe6bH9Kmv6qoNFQnI
        T/jVner5VY+tFdkBBXDpTTRnfj9L0L3xNm1cCv8BZRZlUrtrpaToiqIu/Q1OQHEq
        aVf/Rp+zq4X5p+0sTFpby7Xt9fpI7LLYqKPaXqnq2KHYDS9+qYr+LlvhWIz6xTxA
        0Fnfa0vMPzCBXgGMk8Rgx0nqeTHM3uUTpQoxAoi9PxeGTxX3tuzKqXGu2XSGNcTf
        kfO/8kV/AFixunBECciIF4vZJmpLliMLYPwX9L/Tq6LEi+0akKPU1p1pafDd2NMt
        VMQLzlzMsoFWf+G39MyjKobc9JO+zLfMi5A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id skvNqCBSf_yu for <linux-ide@vger.kernel.org>;
        Sun, 19 Jun 2022 16:24:13 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR84F2s0zz1Rvlc;
        Sun, 19 Jun 2022 16:24:13 -0700 (PDT)
Message-ID: <00ab0088-20dd-4fbd-f169-d177a0bcf424@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:24:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-eh: fix sloppy result type of
 ata_internal_cmd_timeout()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <8177b862-694b-4efd-d079-ddec57a40e33@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8177b862-694b-4efd-d079-ddec57a40e33@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/19/22 05:38, Sergey Shtylyov wrote:
> ata_internal_cmd_timeout() returns *unsigned long* timeout in ms, however
> ata_exec_internal_sg() passes that timeout to msecs_to_jiffies() that takes
> just *unsigned int*.  Change ata_internal_cmd_timeout()'s result type to
> *unsigned int* as well, also updating the *struct* ata_eh_cmd_timeout_ent
> and the command timeout tables -- all timeouts fit into *unsigned int* but
> we have to change ULONG_MAX to UINT_MAX...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.20. Thanks !


-- 
Damien Le Moal
Western Digital Research
