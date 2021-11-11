Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34142C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 03:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F57061177
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 03:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhKKDew (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Nov 2021 22:34:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37365 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKDew (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Nov 2021 22:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636601524; x=1668137524;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=YSfVGQ8z6Z0weMtmITkzNe9e9ctABDRbwu6tDBFvrQo=;
  b=RoLBKJgA8wT4U9F9P3Nb9NvUZTJwSAFhPPkaj4tQw14YNqqSBlpk50xk
   du6gpzxh/ju9jsGw9GHlR/kbI31NIccVM7QyW1Tvb5YAFbbro19EhTMmo
   fxz2RZr+Rn4GXkVdJWXgrT2J7vi/12xJSm+d4x5jnqLTmPup2dF/DRbA0
   SRiThTlB5E89IYeSZnLAuinXJ4C8fBhiBZjDA36pzZWi/yNKtTCYAccZ3
   l4y8AnHu+fU5ItSubpzKXL20Ywja+fJlSWTiJ15RZyammoaryPgqM8jrx
   7OoEhMIQBIzRGaSoQQb1N2bam6ylJJkoz+ei0TysBsyzUARB9Ybz5u0CK
   g==;
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="186299208"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2021 11:32:02 +0800
IronPort-SDR: mFqmiWTHAmxsIKNJePHfwDmqmjsEsQ34YxNplE+5vRlM+E4GxZ4GNGRtRDU8HZKQ2ZEkBVZUpb
 JyZHyeiwzdQQQNGxzA15te/RqNOX8EwhdpEbHYzqCNnwr9jbrXStfOycYqZU8T6ro6SCNtC8ZK
 bw44Gz6S6jFvF3djIwck4dTPHdduo2mfHZOmiveh3a9yeySDOEg0TCageK/BUXGK4yOdBW6LAW
 Wv87eRQOdapwfW8p9RqAU4j61u7xsHnuxhvjdEHtQlBt9qxyOS47SmWG3o1n0cRpVAMKQtWWWd
 icIkBwUvUh9Pdty8TCTof2Fx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:05:38 -0800
IronPort-SDR: mQ3EWo7EyW2aNCkatd8JNjkBN0nmUTCwXZMSsU7ZWA0k5aFi3KnyuPZkpEhpDQBKWxHI/lERC/
 WC6OEzOwHeHzlcoRSe1uh4XhkUtewxF72drj0USKVTzOy9rLwGohHRGsRLzhGu2lBbIlgPC6ab
 PZ+gHK0enydkn9aO/q5qoztMyMvHe/hLJjIPZhJOXQOvNEKbj+4taZy2EeVvLcJbkqRM2zvcDr
 HPXW02JJk3uF5cC0/LgeX1jn2CsrQAaZ+gmDkGH2BZiC6elTwwff5ms1pVFfRzvKUg2Yk0VlaP
 Ito=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:32:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HqS290Cpcz1RtVm
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2021 19:32:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :organization:subject:from:to:content-language:user-agent
        :mime-version:date:message-id; s=dkim; t=1636601520; x=
        1639193521; bh=YSfVGQ8z6Z0weMtmITkzNe9e9ctABDRbwu6tDBFvrQo=; b=b
        5PCCDUztiiaeWi3lgzPA/dt/wnD4/AU+P26JDdZdJvZg9qublcdPSk7W6TsGmh7x
        u6skYW6Yzvn9GjeYU/vhUrqMAy4WqaVuLQISFhaYX7z77BIaUIWZB/uALUG/8+uL
        gWfC1Yuy1GkABOruCRItAsrpZN1CzXunqA+B1bLL9FgXSKUwGyyvGq6f+cauoevM
        Ziv91y0Th+YFwoOdeegN0wYqYBn06oIue7AgNfyhFX/7ukm4S+/26XznTj6vrGWv
        fRMXL7Rb6WotSy5HgRZ462pE9MXc394+VB6Wt0usXgueflj9sXNbyme0Ct4pAJdq
        41yE4w6kfsnKfZWhsytlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r_83YTiBxFN5 for <linux-ide@vger.kernel.org>;
        Wed, 10 Nov 2021 19:32:00 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HqS2772lbz1RtVl;
        Wed, 10 Nov 2021 19:31:59 -0800 (PST)
Message-ID: <4b3e8a72-0b48-95e3-6617-a685d42c08fb@opensource.wdc.com>
Date:   Thu, 11 Nov 2021 12:31:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Problem with scsi device sysfs attributes
Organization: Western Digital
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Bart,

Your patch 92c4b58b15c5 ("scsi: core: Register sysfs attributes earlier")
modified the scsi device sysfs attributes initialization to use the scsi
template shost_groups and sdev_groups for adding attributes using groups instead
of arrays of attrs. However, this patch completely removed the
sysfs_create_groups() call to actually create the attributes listed in the groups.

As a result, I see many missing sysfs device attributes for at least ahci (e.g.
ncq_prio_enavle, ncq_prio_supported), but I suspect other device types may have
similar problems.

I do not see where the attribute groups in the arrray sdev->gendev_attr_groups
are registered with sysfs. In fact, it looks like sdev->gendev_attr_groups is
referenced only in scsi_sysfs.c but only for initializing it. It is never used
to actually register the attr groups... Am I missing something ?

This is at least breaking NCQ priority support right now. Did your patch
92c4b58b15c5 remove too much code ? Shouldn't we have a call to
sysfs_create_groups() somewhere ? I think that should be in
scsi_sysfs_device_initialize() but I am not 100% sure.



-- 
Damien Le Moal
Western Digital Research
