Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3402C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 13 Apr 2022 03:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiDMDti (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Apr 2022 23:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiDMDtg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2022 23:49:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B86369D0
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649821635; x=1681357635;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JyG2zc2ltZDGq9Uym+hFRAgHPsi9AvrGXFiwX/uJ374=;
  b=qpscfLPNyR57RfeMTKn2ytnIxWnHC6yzNVx4fu6C/rP3Urk/+5/X1U8H
   Wdgs26tJZWH0Vpw2xqqkC/N7+cX3xNxgRw0MT1TnAXfPx7RxjW0rUmn6f
   TPEB3mVYSWVMTu2YldStxATaedn/RsFUH2Ms4upcSMebzeI0vViLjI1Y3
   BeXnWpJCI6a+MQg1rnLo77AU3glF6qW/wkz2woKREtPOOf6Q5CLpfSs3r
   aFpm+pUggTjXgWttgbwexoWG50zQ8YvmFq0XtLvPeKa3Phtsi8ydBju+D
   uvka2RYWwwyC/Sx2eCZBAFI+javGPnzLKLpYDKCO4g4aO+Arow2aF+VyS
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,255,1643644800"; 
   d="scan'208";a="202645485"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 11:47:15 +0800
IronPort-SDR: H7sFsc0KmZxL6/l/aQjAatRJpl+iiHGJ+W/rR0XY0tGTY0VU+avvOaG7O/D7E9A4beXyW4cjoS
 pH2ZQCWfHgf00h+cmHgAIpnJyueTtUVaCtuF5DqbvclXLxz8sZTIHcbpPLd3KNYufaiVTDfNQ/
 x56INma3tQgt2Dn/v7gq1L4kWBwxLVpBB249A3qlzinHRzLStjd4a0LmZ9IW3L7YsIE8950FWR
 jFbiSNU2xDQx74ItoQhmS52nCGrNgMH8h4HUIe8s4TXTwFH3iYK+iuKHUzcdo/tEYulDQUR1HM
 Xq+BbnvKpaPas5Lqo9RpgtFH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:17:44 -0700
IronPort-SDR: g2j3mlHyg760wi/DgcZFpuQ5XryImWkFVnYIsRreLOsaqJhSPkniptcLT86JYtTPwK/eVFeuMh
 5JEDE8XOhMAt6eF1RxmyKsYOAbeIJqBZC2qXY4VNW/S4LPK/5UIxXMZPjs9XUW8Ri/TOdxxzwx
 Ppd5zgZ8c1YgfSXEiI4f49/Q6SKs1tXyL4kBd6yex30sSno6p413cAharGOzRiOjxLT1n/utU7
 Xa0F6yUSblmEp4Lx1i21pJylS2o0NtIQNvlbcVKKmp00/wFrFgx7Fd/VQ6wrmGmLLyCfZ4dopG
 cJw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:47:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdT782l3vz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 20:47:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649821636; x=1652413637; bh=JyG2zc2ltZDGq9Uym+hFRAgHPsi9AvrGXFi
        wX/uJ374=; b=cCUApjWzFfFRPL3scrksxBBTfYep67EFZT+cZKvlU5RKxLTn/wI
        PISmM76eMa1EE/GUsxfNn4f5IqGCTEqAUVwJXTC8pJ2GOCowSYybuDrTUoHlA9hr
        kHb8EP48E7ZzLX21tjU2rEGuCBaUwUeFbte+YUI9Vz/O769Ymz5u2pqxZLLqhyp8
        k58LdWP/b1KYYgzMHowAj4OjsxsxvmT+bZ1O5QpDeS6vVxRigfYL0diXvKMehqxM
        +Fnow+VGgLJiekH6dEiYWegTa2RE8EsuQ9KjtnJi8X8m6erbkBTGKMDSv2TdKyAA
        7QDDJ9Bb1oNJoiGfvo+MsLYs5fVDCATOVpQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jIqj_wh_54H4 for <linux-ide@vger.kernel.org>;
        Tue, 12 Apr 2022 20:47:16 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdT775GwPz1Rvlx;
        Tue, 12 Apr 2022 20:47:15 -0700 (PDT)
Message-ID: <14356217-bf85-a89a-b439-111cb86e1710@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 12:47:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ata: pata_via: fix sloppy typing in via_do_set_mode()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e8d0b22b-9052-7cfc-4088-b407643c4bf8@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e8d0b22b-9052-7cfc-4088-b407643c4bf8@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/13/22 05:39, Sergey Shtylyov wrote:
> The local variables 'T' and 'UT' are needlessly declared as *unsigned*
> *long* -- the corresponding parameters of ata_timing_compute() are both
> declared as *int*.  While fixing up those declarations, also make the
> 'via_clock' and 'T' variables *const* as they are never re-assigned
> after initialization -- the object code should remain the same as gcc
> previously used copy propagation anyway...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
