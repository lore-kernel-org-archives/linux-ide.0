Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03990C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 05:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiCWFyg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCWFyf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 01:54:35 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269DE40
        for <linux-ide@vger.kernel.org>; Tue, 22 Mar 2022 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648014785; x=1679550785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=au+ERu5m71YdsbRYnHasfquEzLmwfMRgnitjNITmxA0=;
  b=oD6A6P6NmTpzWpKlQFcanfbiE0lWAGUQBZqJW/98oHnZPAlNGcSvNc/A
   TNjIxTvWp0ApPHUl7DjXzRvqlHgeV/1j65w6w5hs/22UL1HpRSztudCVU
   5HBk9N5jhZGESvVsYEd/T1XzVNXAi07hLAJ3UjCQa32dSgyGsUfF6zrAY
   QvlXAOxORIbW6uR/xdTOjRmPgtXQrkccUKaqQCxRi02vOV80KoeP8bfK5
   sRc6JbQuBYB2uYYhb+Nz0rBZnuKXRXPHGqkWlXj7DIyApCo5EwItqnYmh
   Hrc/XsCeiD76xIPcCppWWBQOq/bEaYt3Fjnv2FrVEAi+D+SU39vl1kygt
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196959244"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 13:53:04 +0800
IronPort-SDR: ebPhPUwm4CXv1ordPjiuwX1zclmtb3DhXAXLaY2kUTGE/zzYYeXbvISJV4wwVky4DlI0ba0WzU
 iFhSDxGZirQ3bNvOxB2Jb6+jF5vzBE15bUDhwNCCaR4SvdfF0WEwUMCgx7TUlgS6eEnB3QreMA
 eH6yIj4R6u6qpkajXIiBDNCsC/dhX6QFdF8CIJwPzb893mMsG3thBg3xZD95s0Db91Gzb/4p+H
 pgNlPSq08rNrxlKP9fo1BG7eiIdpjbttKsOnuP7bTqRZ9ccKxO5zMpGKw4teA7pmSL6TGSlDUH
 oLcTyVmHD1fA1EszmjkfJFsp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:24:03 -0700
IronPort-SDR: d8/DLFwAx/sduh59a4INnxrsFlkMK8nZ1DdK0ZBUlG7fMGCEh4BlDTEjGnxJa9nPGmbASOwuAR
 uh/EfQO0vUcwt3g5HFG0yInfc7XEqEXvrwanNax5XpuuVEJxSFSSsCDKNj8dNnRyeDRgChSjzA
 2PH1DM1KYY2PVGqkQ9hKP2xqNvF3KJYPoZB+3KSiwlznRbyy5p9rhFA2G21E5+y5+RI5osXD8o
 lauq1PPgzx3PyjgBqnpWyDvtJS0NyEtpZIWtDZZ70pfyAXg+9kByjQX5p1RPnJPTbsOs+NUlk+
 6EQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:53:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNcw01CPtz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 22 Mar 2022 22:53:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648014783; x=1650606784; bh=au+ERu5m71YdsbRYnHasfquEzLmwfMRgnit
        jNITmxA0=; b=JCBIFcgwa1MJo9AT1hflh74B91Mi3mhzRr5qYjL18XOucycSN8A
        OXdxy5+17Q4H31Fr7m+avEEaBWloL1cIxPuLS5P31deOAzYaBO3/rzvKStBQg1oF
        VQfeBV1QAKLdDjWGk4c3ydhGCwl72OwFaxSBP7FUJ/jBmUrZeiQ6roJGgEbNhheU
        J2ILYmbCZDGl6/+MIlex8gQxpnCX1vFbNaj4o4AEp2q3OTf7wEhxxnqUpd2CpXm4
        3WYr2lism7MtoJw0Wm+ftS9wl8WwcqUDA6JdJ+OoVPxnryxLpAAkBDN/6dAR48gE
        2yYZA9pw1wqSPSf3d4Gb/Hc1WFwDtbPoqxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IVOlOgHAJaqH for <linux-ide@vger.kernel.org>;
        Tue, 22 Mar 2022 22:53:03 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNcvz1Qd8z1Rvlx;
        Tue, 22 Mar 2022 22:53:03 -0700 (PDT)
Message-ID: <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 14:53:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220323054001.17344-1-diego.viola@gmail.com>
 <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/23/22 14:52, Diego Viola wrote:
> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 3/23/22 14:40, Diego Viola wrote:
>>> Use the contraction "it's" instead of the possessive form "its".
>>
>> Well, while at it, let's use proper formal written English, so:
>> s/it's/it is
>> s/isn't/is not
> 
> Fine with me, do you want me to send you another patch with those changes?

Yes please.

> 
> Regards,
> Diego


-- 
Damien Le Moal
Western Digital Research
