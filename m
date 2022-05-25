Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F4C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 25 May 2022 11:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiEYLLi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 May 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiEYLLh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2022 07:11:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B133E0B
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2022 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653477094; x=1685013094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ApspzUBKpnPb41FxJK3phqUVQ+mxeo54ozF/QmwScU=;
  b=Ag02bwg54s/Qj6Hwf23GVWFKdzm5lIiiMWsIMxiWg9uURf+ubSTDludS
   9hVjJjtW6RRfv5hU27mYSTTBGpM6+8Ux5irkFRR5wzop0ioLlBC9wj1zk
   c/xZMVej5FKWDvRfb2wxtrPBLyvTSqrBnM5F61hcv+IpJn3VwbimULetM
   3X0C6zFOY5ucze01xvmvcFfaQbKjVSsBMBD08h2Qq3q8cpL322LQlwVwJ
   qa1BLWpPieFGjAJxMIPhP9rN/q3Sh/KkxkTrvRAUiJwd925z+kFRRJhGO
   5iuG19KutPnQdU8zv3o+G+jodyusBf1Ew7HJvrC1UVA+m4aznS2RD7em9
   g==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="200173549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 19:11:33 +0800
IronPort-SDR: g6TCurx4LWODxKG8YeA/uRY2EZzJ21nVh0xool4bB4FbE2hsmPWhFxT7wZSfKAAYaQrNHjcopV
 2HEowyiF71Exg9YCA74fvcSR6sAaFNBumF9CNghG3mXYjlONy6uq2cYONBAfesGtRtSIHdH7GZ
 BAiaheJK3r0OWkZC+CKTMRf5twOFum6b/60vWI3H9pRop/ElkyStA11tTnzYezKrJaYXVd5BKN
 oN1apWPB5ToSfeqq5kzg6oDvI2tUbR8Nm/h0QRR60JfsQlzWoclIPSTSgY2czO+J9UeT1bo6Sh
 fupOpz6yB1WeJfrTDKMqjNKq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 03:31:04 -0700
IronPort-SDR: uW3UGQ2yi8xnHwK/lPB6hzZq3U9I+gGkgHgB8mKFbUbzJNF+NU2pivAn7Xnn4vzUl9bNShjbdr
 yZvaS7rml2JUscDLJjQHmqnoEjyV2bwO9gtAmfU/I64dg7gXdOCLKRoonDWbhrFo+XXYAJMci1
 3gwDPzckOMMfWd1d+u586Q7anqzM79uv9BQe+DFIVe+bULa2GsVuNpBhfZXvHflcaK0uGCLRJl
 vmFF6MglVoL0Vkr2XHGlYDS97jOZ0JDbWotY5Sfr0p6b47HXCZ4a/QnRvQUzsB5uQ9RLi+s05N
 yCo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 04:11:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7T0N63tJz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2022 04:11:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653477092; x=1656069093; bh=1ApspzUBKpnPb41FxJK3phqUVQ+mxeo54oz
        F/QmwScU=; b=gimYfpIJP7lQ4yMAIpoZzyEWNEhMXnRdQibGB1an1gd6dWPOTXj
        iNvaHhqmQnGrd2kZ+0ikb9Azx+6NjehJfAqfUAJyfsEaA/AwQNhDLhFBQKWYPDHh
        aoI8M/p/E2Lv7W6D4oO+NC6mKLHZY6zabvT1g4MnExytLEsMmFbPMGnPLcDMLy4H
        oksHMJ4m0pq5ja2juHcWzzBeO3qDnOdnAO5ed8nDqCc26vVgubMfjZ/3k7SqedN4
        SKCrISvnEtihumQaXZ75C5AKw/KG1jQ/bxZQxLAM/wGsJIKWMoyPw12/ixPq7ZvP
        dSBfSl9QfoAQRTnhMzvijKIcKngks9M61BQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9n6rC2yzeKMC for <linux-ide@vger.kernel.org>;
        Wed, 25 May 2022 04:11:32 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7T0M2BqLz1Rvlc;
        Wed, 25 May 2022 04:11:31 -0700 (PDT)
Message-ID: <48012e6e-f3c0-4436-5f5c-a2b0db89e33b@opensource.wdc.com>
Date:   Wed, 25 May 2022 20:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] ata: ahci: Rename module parameter for lpm policy
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220524170508.563-1-mario.limonciello@amd.com>
 <20220524170508.563-3-mario.limonciello@amd.com>
 <Yo3w/dsaly+gcQNR@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Yo3w/dsaly+gcQNR@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/25/22 18:03, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 12:05:07PM -0500, Mario Limonciello wrote:
>> The LPM policy is applied to more chipsets than just mobile designs.
>> Update the module parameter to drop the word "mobile" to make this
>> clearer to users.
>>
>> Also, document this renamed parameter in the admin-guide for users
>> as it was missing previously.
> 
> Even if the name is confusing I don't think we should rename it as
> that breaks existing setups.  I think just updating the documentation
> is good enough, but if you feel strongly we can just add the new name
> while keeping the old one as an alias.

+1 for the alias.

The other thing that this series need is to add the changes of the LPM
policy initialization according to the adapter capabilities (your patch
and the patches from Runa) as well as accounting for the eventual nolpm
link horkage flag. Otherwise, I fear that this change will generate many
regressions.

-- 
Damien Le Moal
Western Digital Research
