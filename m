Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E5CCA47A
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jun 2022 00:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiFIA26 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiFIA25 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 20:28:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A551B701D
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654734536; x=1686270536;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mMgOZuLItNcWZeNn1mAE5c5TjgHithTG+3QaIuikvxc=;
  b=jvanHw+LIJTOEgR98rLvBrx1NNf44veOLqFskrqy2Rjo6ZJTwQn+jcZ7
   Z7bPCtIHC38f0dKRv+C9jFwFJxAI9Fb+qN0HBQz/cllMndNssha2H4vhO
   VugGAU9QhRlsX0hHI+k9O/i4h3GbJ4teelWijLWmUqWLUekEHSAC/pIdc
   iaCb+MOOohHAqs7ZGow46aanVHLHbnuOaluCLF9/lGN/JX+x8DLIPVNJP
   7n3CUaorR1HUvmhQKmHOa11n37d5ycFbXbfSeJMvZ92R1fzVJjg4Zf/kY
   Z136kpzeMBNWA5DBitvHWN09IEysvUrJIQW/6FLiMUcNaxk9zJSym4MI0
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647273600"; 
   d="scan'208";a="207499510"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2022 08:28:55 +0800
IronPort-SDR: WeFicZxQW1BJH5gMYR+bcZhR349C/caAYz6QHF4FLmRnjgltNj4eBMGK8S0rZOLLaD8c5A5W30
 J4vxxgAw77DJO6v+cIRJn3JUvI7Hd6KwxYSjCvqtEDXIVfmMOdBzWa7BNGAjaGa4AVgKOmpS7b
 BAY3jJtox/Th00gLR20yy0Wy+BUUOe3pUHzh3Bq0HN5V4ctpXtOP1QMxTZgrvfey/EoiiZtnuA
 +RBAfhg9Q3ekMJHk4BoK4vQDUj815hytcuvniYyuwQNtk7UtDJd1CpJ6bZafPd7mdvpl4WYPMZ
 q/OB9tk+6Ap/6tUdvkrI5MdL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 16:52:09 -0700
IronPort-SDR: NLzVK68CwzIUopu8GdS4+5m0YUqAtsSo0q9oGF8WW6cN+aaSoer6xIqaqUzmaLGOnokl+gwhtn
 T9kXpEQswYZhN7t+IaoVJnuYf3ujm3H4u8Ck8r4ke/cWE5v7Dexqgwa0+ajn8bQLatm2U6qB8B
 C5objg1TBauDC74OEB5u5RyPm/B1Y+pxcqEEGVXkb3zwvIwF3pZl0DxBxc8TMHZpmUbDebTtxR
 RZEOenMTlvVI7LlsEllKBBAifNFk9yky0gKDWnAOAgvEpN+lXi9B2UN1xG+wOUa82rILTK3fHM
 yog=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 17:28:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LJQ1z5kskz1Rvlx
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 17:28:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654734535; x=1657326536; bh=mMgOZuLItNcWZeNn1mAE5c5TjgHithTG+3Q
        aIuikvxc=; b=TQasqH4wQPXqOgaVaie+twgh44mAbzdAC0FajOxJJ7AT1uiK4go
        rauJFlgM2wow5G5T0FiXFl2YlIXg8b/ZqY/fU8QiivASAOx/D4qJPGgBZiQvVyXP
        T+qeoKl7GzTHhQOO+Kuyvshmdh6Pa3tFhdtgjYcnskCe106WeGTDRxsbxQpleR9I
        +8ukgG53GuO3FJHCHl33YvBnbYsUnwb0f38eLojZ0sA+dwI7c8HuaccJsQhrwPHJ
        zM69tLdCadEfXbcE2VsMzVd7PO5CfQkNPuHLARbHUbozWwqMPgpuwUjTqjnwN837
        BqaJ4T3op41JKRdgRxT1PN60NtBRGntcwQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GQhnTG7RJFaz for <linux-ide@vger.kernel.org>;
        Wed,  8 Jun 2022 17:28:55 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LJQ1y6DSwz1Rvlc;
        Wed,  8 Jun 2022 17:28:54 -0700 (PDT)
Message-ID: <ce246561-4afb-f66d-957f-2848dcde4cdb@opensource.wdc.com>
Date:   Thu, 9 Jun 2022 09:28:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: add ATA sysfs file documentation to libata
 entry
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <fb6ea0d3-c962-26d2-16e6-a7782d39a0de@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fb6ea0d3-c962-26d2-16e6-a7782d39a0de@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/9/22 05:37, Sergey Shtylyov wrote:
> Add the (still missing!) ATA sysfs file documentation to the libata
> subsystem entry in the MAINTAINERS file.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'master' branch of Damien's 'libata.git' repo.
> 
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: libata/MAINTAINERS
> ===================================================================
> --- libata.orig/MAINTAINERS
> +++ libata/MAINTAINERS
> @@ -11257,6 +11257,7 @@ M:	Damien Le Moal <damien.lemoal@opensou
>  L:	linux-ide@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
> +F:	Documentation/ABI/testing/sysfs-ata
>  F:	Documentation/devicetree/bindings/ata/
>  F:	drivers/ata/
>  F:	include/linux/ata.h

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
