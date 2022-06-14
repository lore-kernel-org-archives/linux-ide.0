Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B78C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 09:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiFNJEH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiFNJEG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 05:04:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B678B28E35
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655197445; x=1686733445;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qaMSIUl/tK3Dl2jkVyiDdDX8lFVDj3u8zx1xp0UX2cE=;
  b=m1H1lkbZr898n4yBIwIWsA16hcDpto6Y5dvr6TkxdfHW9HICRLWinhVT
   eh+qvn1C4RGJELFz2m0fAJx3D3HEPn6LUccbxkKK6/fGoWSc3rV2itiiR
   1U0C4NjFxobDz2KXcQifbEsd//Olpk+LDb3ghzt8pPuO3JnReF1ZAVGTu
   1HDonprIpHeuVjlCdrGDjSO0qTC8WsTaCKI/dPwmgwbj/e/gzSsNiGyau
   kdLwyGAfnG/q327w+/CuTr/D5I/8ZWvCZOyE/QqUjoRXwC8pbRl7hFG79
   9KJheGHR8eGgRSclarIei/vEFIYhVZUkx30vlcE2AhIqryvCH1hQLJQsJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="207956338"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 17:04:05 +0800
IronPort-SDR: XMiT/10uPJvkM7uP2HoUflu7fIOyQsKVt3fNsY90kB9shFll03B/KGKuPoFKEP0HryKCZ4oglq
 UR6eyHW1qCBt9kexVhmbFsUEK3xUmAIUWnZGm3eo2TmUZkGX6x6sN1uc9OHFf/tSqgT4IEtHfq
 SFklscFNVcF1azxsRAvmZKGRDW4AdOdEB7DmbSxWglMGdASJ8xQi7Z2aENJvBoR+HVonBS03TD
 2vfkvcTf+JL/ljYlT2rq+tno8x2O2NOtMpX06t0J5hJyam1/HCujnVGk1m4YZCNlWs9t6Xpp8H
 jUYjrbHscSarUXnD/JHf+mjC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 01:22:40 -0700
IronPort-SDR: 75kc6PaJmILiXDXGLzPJ1MxxKgr2rPr14IZZfEvOpaI9qCDXOxegnagdLVGH15kNY2+p20Mi+k
 eOllYyOyEqrhZcBCKuVdJIVXUQTNlP76BBgaxwI3WPyXVChFtcJs8hR6Agwk54sNyMK6lMH+wX
 pssAuaV24Mk15FGzcclSi/MhoLDMORGENf5e3jk6FP35MSYkycy6u0ho4KYQT/qGJTOyVzVoph
 gEhDe9TSMtZ/axSL5KUi8Tr4t9ZVobTS3cWu8gCu3sBwn44UvUHylRl/wKB3w7nAxv2xdkkZMW
 ae4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 02:04:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMjD500DBz1Rvlx
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2022 02:04:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655197444; x=1657789445; bh=qaMSIUl/tK3Dl2jkVyiDdDX8lFVDj3u8zx1
        xp0UX2cE=; b=HH4tMEcia4/2bdjm2G7xSAL0vw1Tq/Zzm2Rgqh8MRatdb8GYvJ+
        kEi8Z4l9vzgRyb3J4LcK28JsXENrFIeIG3oGLOdmRDHMbHRRD52GjymEKyeAJYhr
        k5+54vQwrBNCt818On5D/P5ta1nGq4tWnYvkycrct6/x6jsKmKhmG10S2LMDFJtk
        8T8YzDDMnNI7F37yIVy8w4Ru+mCjAjl1tcpk4PZNYBGggtnSq+zQeTNHzCbisRsh
        LsZHMxb8HEfEljeCaeOyoVqpur0vYTXk4dMwVzr1XnnerfQaMfils2ROGtJ9eZUB
        PLZ2BOhkuXiiPrAALWPTlVNy6qUzBTR9GSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cp7j7wdH8oZz for <linux-ide@vger.kernel.org>;
        Tue, 14 Jun 2022 02:04:04 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMjD42hL9z1Rvlc;
        Tue, 14 Jun 2022 02:04:04 -0700 (PDT)
Message-ID: <ee7a1175-d3c7-53f8-47b7-f2eeb7b32138@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 18:04:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-core: get rid of *else* branches in
 ata_id_n_sectors()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <9490e8b7-e601-ecaf-dc94-d0f5fb63aa5f@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9490e8b7-e601-ecaf-dc94-d0f5fb63aa5f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/10/22 06:06, Sergey Shtylyov wrote:
> Using *else* after *return* doesn't make much sense -- getting rid of such
> *else* branches reduces the indentation levels and thus reduces # of LoC...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.20. Thanks !


-- 
Damien Le Moal
Western Digital Research
