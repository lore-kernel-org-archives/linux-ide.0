Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17685C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 12:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiBJMhw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 07:37:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241643AbiBJMht (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 07:37:49 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2FE298
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 04:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644496671; x=1676032671;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1HmhbI6GsQDfxq5IoL/b2jCxpQWWjCQn/x2F0RiR+Z4=;
  b=P2iA/EGhLVU7Vr9S95n7Exl42aXiC+trKqwiygBfk2quAZF+IzxmWWy/
   Q0gviBw23TOvQd+JYsf9zCykc4YojW7kyLsTNLTalMLG4YUOcmK2tes95
   5eF3REVABmfa3Vr1NozNJg71XIshsbn8+bGS5asj2vk9L4UAiw3k1K2/V
   Z5aGWgMAy9oYYqRfVcavMcAftiNqrPB12UxtAQDViu9n5v+X/bxO6cbCM
   g8UeSma+wf0smbxCouUpadb5KGatkoTWlIpOPDYR4zhyyE0WeFY57eIh7
   ZYHkPshn8Pzdcq/HKo/94EkuHLFWlSH7JHueicilwIudiWAFanOduYMMn
   A==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="296698486"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 20:37:50 +0800
IronPort-SDR: de7/JRfEYBZbbQaB+9VvmnHa+c8i50CjnVE8Mlx8LUy/ZXoI2qYvRThDiuLrU6z5c94NQ8V+of
 SzmR/LlYHx2sB1wRPh4TG1peziWQjXVTD2dO/jr1KUr82QbnvKU3UgExVFcuda/Xvee11ugLYY
 oOK4yrSFYFSVsM6Nnr/dQpiFuKnIwF6mqtOYBQPdLM40Pk8g9q5O3/LPSCqsxMwtnd7aBXa6MO
 cnMP/sREg1dzA4TnUz5wGR6tOdMeqxT8qQACj9+TgXIoD+2mjKcyeM9VlkTbC+kiG5Xtqm31Xq
 QEirkzBi/s14TiaqR5c/R6tl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 04:09:37 -0800
IronPort-SDR: pLCIJaEJFr/3A2KOnSwhecWDZ95jYloDpY1nX73zS/Ri7zsoaio+DV0VczmyTIoC0iSDoViutA
 Ckd4MKU+PiS2+1LTtrp+g0bdajrCJIRjBVBD3Pt0HUpQ5JelfMoCsZHSwtzoQPtdl2+afX0AXD
 /mWnK6S4oiYCzkyMeyHCNSaedk7VAqHr5NaBAWFIcHoJxNy65LnErusCo1uMcvT8wpt4eQ8Bu2
 wdAcK2iC2z17IqHQUiYBM6/0rw65WWTYQnLTnbhtpQdnK3SNq/KqlHPlZgAe5c/hkbe30b4Z3k
 ejI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 04:37:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jvbqy1yl9z1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 04:37:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644496670; x=1647088671; bh=1HmhbI6GsQDfxq5IoL/b2jCxpQWWjCQn/x2
        F0RiR+Z4=; b=ERfzQ3Lv1YztkFLRxuwAe0PY8bxO3ZeGnPdgsPIw0GGC2x2JM3N
        k0BdU0OUoFkZ2X27BlbMMWPYCvNzO5e2sbkrCrkJGI8QsdC/my45OWvVLG2pm5FT
        /MVo/q9l/Hg9nCJaDvjQjAhBsIhwwWqfJIVVnCkNlnPXCVmGt1Pa9ttvze4DiGDn
        /6QGPjzVJbegDBqHmDomNmQiJ7VPTBQlXw+r6Im/p+5RmfwpvKJsHPQR8eqvYpwy
        028kvvAO7nLn+F0yTK4YpYqBhYroc+FgyCV8MgjSuW5dxQVWWbk9k0Rqyu5FEe8c
        fNEGmdhfsbcW2v645DVHWGmfumz1Br73nbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OC1iCaLHZAxH for <linux-ide@vger.kernel.org>;
        Thu, 10 Feb 2022 04:37:50 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jvbqx4bVvz1Rwrw;
        Thu, 10 Feb 2022 04:37:49 -0800 (PST)
Message-ID: <86fbd7a0-ac66-61fd-c796-e320d38f1689@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 21:37:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RESEND] pata_hpt366: check channel enable bits
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <a1d58d20-04f8-04ed-7549-3cac48341bda@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a1d58d20-04f8-04ed-7549-3cac48341bda@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 18:56, Sergey Shtylyov wrote:
> HighPoint HPT36x chips did turn out to have the channel enable bits --
> however, badly implemented. Make use of them, despite that is probably
> only going to burden the driver's code -- assuming both channels are
> always enabled by the HighPoint BIOS anyway...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
