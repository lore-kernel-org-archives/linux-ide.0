Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8DBC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiBCAJV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Feb 2022 19:09:21 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1464 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbiBCAJV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2022 19:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643846961; x=1675382961;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=v1wrIbDp1vvHluaQi8JR+Xb3JVO/xJyyU28VRFr17EQ=;
  b=DjjpSWDjRyDuU3RGjd/XasR8IK5X8QKVewQQbs/91CzSWfnWTu0Yvgf7
   h8oJ2jSgefnZieAJM2UuUfZ97fm7NVRC65nf/ZfQQ0DKVIBn7Nx50j5YY
   E/6UiqR7qsTHbN1pkMbRdHyD1jqWsMs4f2fIDFOpQOy6W4/8/4930PpsN
   fRO5B+G31TK0GnMfq7J5geuUzf96Gjt0brMwcRcxSAp2ngncSxOpZ64Zz
   GR1Il6fdm3oLZUG8fBybJHgueyhBmNUh11IOLpNQwpwfKG2KDbjepbsUx
   tVvrWoMlxs6QC0JtED2qqiHnEUwsGrt6IvDDSmSIsIwKvlI+9uiJ3e+j3
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="296109495"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 08:09:20 +0800
IronPort-SDR: Kw8IfRDIQzJ8S/WzfbNoo+k9gsX+3n1YE63hFqnpxmJnAIbirNgDaUKlPf/vQ5kGC4nPVhA69C
 aE5eA/d3e6im2mLOlA6IB/0xqH2dwyYTATfMAcBFG5bSDARL2X2cPIXQqdn5Ww54OLxyNlKZKD
 KzHkal/8QzdQ7kdiyVsnQ5hTvqhHU24NCmED2clrxL5P59iC6QhDqpRfZVmLkkE6Jz/DxhKXca
 l7/Cvi+ewX8Hn+wrouSIg9CgBrO59uDYTORQn6wTukE6KdvCFXR+vmCtV+ikqWyMMbisZ3W1li
 c2xzUyjeC/4JZo9bGkRmACED
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:41:16 -0800
IronPort-SDR: z5wG5q96JLlh3KcGo5w1tsN6oF4Un0YEC6nUXuyTx1M4zYdV7LRzU7/WhLgEDwY+ioSN/fa72Q
 lzrjeYfiRtFptyLHsIIHqUcohhU7nyRnA6jOg+qIsUVDtHtXOv5uTiGPUMhnTNm/3LSm6PgLEZ
 IYYmS9hEowLNaJzgc0Ktqfh9EFRxOqK5Ni0Nff83IWl7wZ8/nAeDSQzis7D+tAXYpnEi1l1OTY
 JvkTcdSge1L7Y7n/2yMuD85vnkp+gM78VgaESfFWy0FlTG392loGteHRBOlhr/nCF+VfEkhn5O
 XWA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:09:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JpzYX1cscz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2022 16:09:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643846959; x=1646438960; bh=v1wrIbDp1vvHluaQi8JR+Xb3JVO/xJyyU28
        VRFr17EQ=; b=pwiyDBZR170zbF4DFGzohI1o4KsJhWGfAlI/SAKiNwUV3ph6wlO
        ddkFDpgXgVY1feSC5nweXoIIUF7d5n1+AJ+eeO1mF1BMAts8Spj/OlUrLZecx3hh
        gGpkS9Jwj/bpgKNp1JwQb4D/IprEESrGJZiYmaHc++awcz7Ti/r/RwR+jNPTm29m
        KuKiY4WyI60IKkbkQ+P9lSn1hpuViUMdL8O2pb7Slnrs3g1NfpLxkQ0cSEUWopKC
        AcDOZV9nwIBlw8JDXrIRE4kxLEvpMN2vZAkQSpGzgsWjbrzCr3Gh1Ex9p62Bv25j
        aeB61JPNuSxOb7h1VL/pJJSu12cyqT/aFuA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ePJCs-rs3d11 for <linux-ide@vger.kernel.org>;
        Wed,  2 Feb 2022 16:09:19 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JpzYW46Nsz1Rwrw;
        Wed,  2 Feb 2022 16:09:19 -0800 (PST)
Message-ID: <ac4137f0-6a9a-fdc0-bf07-4015876dcc7f@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 09:09:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] libata: ata_{sff|std}_prereset() always return 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <b1d72683-d645-6ebc-bd66-f5dc1bc2ba02@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b1d72683-d645-6ebc-bd66-f5dc1bc2ba02@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/3/22 05:07, Sergey Shtylyov wrote:
> ata_std_prereset() always returns 0, hence the check in ata_sff_prereset()
> is pointless and thus it also can return only 0 (however, we cannot change
> the prototypes of ata_{sff|std}_prereset() as they implement the driver's
> prereset() method).
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
