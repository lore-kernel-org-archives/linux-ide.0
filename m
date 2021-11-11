Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F340C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5761284
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 07:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhKKHfa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:35:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9287 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhKKHfa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2021 02:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636615960; x=1668151960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A+P/NENnl5hbBl0bWfrrG3DPIwXuNAWaXaJ4C76uN1o=;
  b=WxQO1LAwab2i3tp3RLbb2dd7qLbg3djAi/JYywuowsb0dvgL8fJ3jxNH
   zh8uq/o/XyGI3SVpaI20AtBhaC6DOEvgLlRmz81+SMAod9qyR/FulTSdX
   oa1xVrubKckHRwePiFXVJ4aF6oQ0WRaxPHySYA2C9aqotprvl1mXJrQUy
   KpMxxC6SiYjw5/RZzb4PgumHk+8aiRB0RJQfYji3LMMxqkcAZOM7zF5I6
   AstgaynMYGtve+EpWq2roczm3bo1BV9xGVM7cHXwThNK8VmWA9vqLSvMm
   C7xnSuNELnCI/HNSqPcFX3W0MZ58hcTjPggBoNuBSHEFq7WlVmHfvFF+5
   A==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="185318119"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 15:32:39 +0800
IronPort-SDR: WZp9/7KNkhDdvczcUJY+g7LKmLfZseMWWCruTbv0VyyS6MLG+3KV2i08hAaoKaCHIm2l6dZqYz
 8dID4B+Sb5eA5wCuLwiDT6CNnAWVvoDBWI0i22FXDYOvx/iTms17W5YEO3hrtTgyK3H02ONejV
 ZanPzhjTuEVC/745cl8B9rtDs1+esPcswp6qyEPTPxoPKJt3iX/iHcaXxI+MaOa2f2yCuB2+vT
 Z7Six4wdcxBjNWn/qmSNfBJlt/eZS/HTBddFwg9Ga5mlLz+kuHH3uz+UFHf/p3WWV8I14FgT2P
 l0QM7LF+ht9/KYilw0dbputZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 23:06:18 -0800
IronPort-SDR: 7ns1rTJOeusaIB4WDEzya99QN32g4foFLRfzCkVUUugiBbZgniHl8A0R2s3t57utUJDi7cVDvK
 uJQU99p9b+wKBA63Zsd2Swx7z66g2hfQ40HHlUqkkWOaq7wUsk24PdlnPGw1yvGqetKxxB/S8W
 x9W+mx3EsV5nncYpD5ta8YStlzPbj6VLM1V1iZ531XcXJJPdLt8w9TFNwl23O6wARIlY1eNnZ5
 9L79+LbWD2v4zkZkvzdT/H0gSplwulhLA6SAKHpUY48MnoGXk1sT1ts2lYdon/DWFZQlrmgq1h
 I40=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 23:32:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HqYMs1tpZz1RtVm
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2021 23:32:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636615960; x=1639207961; bh=A+P/NENnl5hbBl0bWfrrG3DPIwXuNAWaXaJ
        4C76uN1o=; b=TYDUK403M2cLuixnCZVZ+h9DBMAv+4Dur7AloIePQvdjaZbPZNR
        wB02zJdj9ztcbKYLXdbwK8Qg81/cwvso36vkTq2CdofFmDXYQ9pV94AbHCjST1s2
        B93BKi7Wz5ppa3JjlVMmK6yfAKP6xqUTvLC4KQ+JibjIfBKAvR/VUt9bqqmI2DR7
        6rzC0BExbDs2YSWd3kMVmMLQkr+G8nSa+VKakXjIeT1s2B0ImJ8GhxN+R1jEd1y5
        FXwtQIM453h+SS7qGn9EdAyltQEzVZizgq7jZXfTcXju3Jcxn/BQLFMKrieuW1RB
        Fx3yIstquYJUg+uPfbiyqmq1exRJkb3ZAwQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 85GeK3WqIxAw for <linux-ide@vger.kernel.org>;
        Wed, 10 Nov 2021 23:32:40 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HqYMr4BqPz1RtVl;
        Wed, 10 Nov 2021 23:32:40 -0800 (PST)
Message-ID: <42bb3e74-d832-bfe2-c242-eab6dd13b27e@opensource.wdc.com>
Date:   Thu, 11 Nov 2021 16:32:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH V2] libata: add horkage for missing Identify Device log
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org
References: <20211110081441.587089-1-damien.lemoal@opensource.wdc.com>
 <YYzDKYG5DVA4N5sQ@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YYzDKYG5DVA4N5sQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/11 16:15, Christoph Hellwig wrote:
> I'm still a little worried just sending this command could blow up on
> really old devices.  But I guess we can deal with that when the problem
> arises:

Well, it has been working like this for a long while now... So I am not too
worried about problems at this point.

Note that the first access that detects support is not to the IDENTIFY DEVICE
data log directly, but to the log directory page. And the log directory page is
supported since ACS-1.


> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


-- 
Damien Le Moal
Western Digital Research
