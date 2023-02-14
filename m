Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14444C636CC
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 03:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBND2B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBND2A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2023 22:28:00 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88AF17CC3
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676345279; x=1707881279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x7YyVY/jHHAB7fpCW4JZQOTnIZ+pcM1OEZf7EKFnVMk=;
  b=HK6zYvXYSdnUCeOOai6Vazk+aGtSX6W8L/MyFxtrr3hvAgTeJ3dQQUtJ
   C5olmEnO385jJQ1NXzzQVfDzy7HWPzzXVcASamf2TFX5574mzL3+Nps66
   wJ3s2oaDYFlZiSKHUUj0AkCBTt0RDEbZPsNbMVLXqtqdZdXiuG57RyljO
   WEB/mkXqFbQkFmWLSyOd5JZelUUaG4d7t7H2NKh6QLdxWMrHhoQN0T6tp
   q8CpihcDewtxbUOukvj9jgc513BILGuIswBcYQYXc7SWxB+9bGm4jGfxa
   3GHIXN4mk/SO+puqVopicqsBc1VKHxfqTqHbBk3MgZYn6h15yGOuLvfgB
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="327531635"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:27:58 +0800
IronPort-SDR: 18wT82WUpkclnIGx2N2kY1UQHL3gn2jmchUQZYIHsxFNcN57X9KIzKFEpl6Fd1bezaKpVS/Ab5
 MpNZaiF8BvPXyVVgvI91yC9SWhgoWufBuYb2oG+FwGh1E4EtmZiZXdGNtEd27RVu/jwDAO5wzI
 A2/uFY+wtQOaef9lTFZGXLXWRDeQVgJvIjBzCJ4hD364s+zQLiODLIsGHVPnvFwMDfPVl9pYgI
 d/84gF9fuAhJM/HDF6qgwFl+jDZNuklOI70Qq0GAzB/Rp2wfmqYfeYIqwqHihZW3aCyAk7HeV6
 o90=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 18:39:23 -0800
IronPort-SDR: pWoeH5T9MjJiOgOWUa6ovsu28aYZEdr0Z1J6SfGxg3+G5wTfeBO5ItrAkBki6/cYWzRGwzdt1Z
 CX0lB0PmtADTqslxarTzPxRVUHbp/UhWdSRe0DS/gh3cgl02Ko4XYNszabsqhBnGsMdSZVRNSK
 PjftfRvSB0fGNKXjtXDFM0LW/obwgvs4ZgS4P4EQq48dnT+C/CU9S3/wxc/dt0Drso/vNmRUs5
 8OETCfZrtQqMorlzhqVP71kGfbmX6U+8iHJu4LHvPb0hPQf7SDT5lplYdC5ZfRy5tKJK6AQM0N
 PfM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:27:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG69B4X5Vz1RvTp
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:27:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676345278; x=1678937279; bh=x7YyVY/jHHAB7fpCW4JZQOTnIZ+pcM1OEZf
        7EKFnVMk=; b=B4m9jBTFsbAsqtZyw8mA5MpFhxjTSCHBlwdei7RWfEb1jSemRdq
        C5cOkixbuwjJ3uXpJOWE6YxijWDbBkcWb9ukf14ycyfWYJzrTSGc/4UMuvANWquo
        9S0YFZfkDdSCRboYBdCrFk88TeGrGFHHLKmN+onyWnGEDFxGMyqNlv2i0UmqbZ26
        fhVkuykoV5nPiMNP0l9hMsTcKuGVS2+81F7nmpT4zCJdpVFgHHBsRGDQG60nBxT3
        Mhbwk6nXe3j/B9haFvsGdKmjPfq0xw1ePqF7aKXvDAhAHsSR0/X/ynuWfB4UqJHl
        Clu7WyZiLhO2oueW+3xQbQgJUTS0YwennEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BxxDC7Fk_4qW for <linux-ide@vger.kernel.org>;
        Mon, 13 Feb 2023 19:27:58 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG6994vVMz1RvLy;
        Mon, 13 Feb 2023 19:27:57 -0800 (PST)
Message-ID: <51d8201a-5677-e024-8ca4-f0c73795884c@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:27:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung
 MZ7LH
Content-Language: en-US
To:     Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org
References: <20230210215151.812839-1-chutzpah@gentoo.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230210215151.812839-1-chutzpah@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/11/23 06:51, Patrick McLean wrote:
> Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
> SATA controllers:
> 
> ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
> ata1.00: failed command: SEND FPDMA QUEUED
> ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
>          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
>          0x4 (timeout)
> 
> Since this was seen previously with SSD 840 EVO drives in
> https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
> fix for these drives as the EVOs have, since they likely have very
> similar firmwares.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>

Applied to for-6.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

