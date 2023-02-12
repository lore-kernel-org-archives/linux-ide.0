Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D9C05027
	for <linux-ide@archiver.kernel.org>; Sun, 12 Feb 2023 23:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBLXMK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Feb 2023 18:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBLXMJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2023 18:12:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB655D522
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 15:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676243528; x=1707779528;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fkvNaAhz/jlkbZTMMleN97ar3/zq0mYEe/HvwvniOls=;
  b=coEfpuE2hpyMxONHZYf+xioSRSJ4HvdMIzI1ApmHeXxTv1sDlXg9vcIM
   fq6Axq6XkdFzRgKQUQOi0EUKKU6BuzVAoWpXosw8oS0/7SpJQ69qvD37E
   nv2hWQFhTtwsqwXEwX2vF4Zrju/JGetRMzJmYXllLvK+WdjSDYjPyTcLW
   8Msirk7Z19X3dRcq31TER89wMdX3MJPdtaGeoxOC8bv7nGgLrgPZIdOaC
   2LK97kT0zh0xA0gkHQjZq8Hv65vDyjGWU1Gnnsn4NP8drDYKl73oH6bRE
   lywcp+FiYkllTOdTj90wkW2CYel3nbQB8+1lBZdDiM6zAw19xi8p1SZIG
   A==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="223155146"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 07:11:52 +0800
IronPort-SDR: dftihdDvH6fa44MKVl4C5W9NfZ/rRna40Y+lUXiCwl/2CU3QcPz9ykpyrJ0mMiDvbbxgcbmcSW
 HUh2UmX2B4Db4yGwPNrMvKXg0poZqPzb36+4wh/9BskUkeIRVsNc92/k+/YpZtDKY3curFnmtx
 4XWtdoHyzxDAO6Fdx8E1CG/9oZaAVxKB5QBge+3MdleZVANxtvrlsbAKPSaB0/mYPuoqlWbL8P
 OKwNbdtlXAfFlz9bTBgczfhuMq3U/PCh0FADdTpfFKr1bJWIOT/pxCN+AZ2fk+S9OC+/2ucgug
 8cI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 14:23:18 -0800
IronPort-SDR: LCJ7zkL/25p8kH150adSH9SwNMxp0RxQf+I7u56su/tlN4y4R+qzvifWeNQFuJrezl9jpbn9CA
 pdGS+53wtaoJCLKOOWglQzAEYmH9Jh4w57Gi7o2DuVi/bzYwIV+ZArMhOMeD6lQH8u++eLw8/Q
 VeB+2xdrhb8Jwim7gH+TCOu9lokUd/tD9P8Gtn/2zDszRDPkdgWbLe7fEW7L3q/RiO0CS+/+Ib
 YJITHuB0gaVesHTrjWevi1uucZ4uvTGqv9LmKI9z+w84Zjo4+wISQOnNVw1AxYjWtkmS8pwLd/
 kU8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 15:11:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PFNX82PKDz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 15:11:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676243512; x=1678835513; bh=fkvNaAhz/jlkbZTMMleN97ar3/zq0mYEe/H
        vwvniOls=; b=TnNO19RNK8Oi5wZBwSnz563QtyMHvL3rIIoC0fEyOyCP6xfE/eq
        MG+UUjVU0oWIlhahWo9zmuLBP+d8E9p2+Tf4hQeyzeUNCiUXA4dYKbvwepsuwpKS
        fOCZZJ6HES6YVE79/JTNrQooNJuoUA4Fkhuc2MFKD/Dpf3L/wn7yh2DrQqwRsobU
        BErD9b7nAcASS/6ZRauK9Qd5AcRrxIaJGl6HCWF7bfUgZChzbcMcJHOqEpFPW1kg
        3F7zaX109n3s83eiRltiyK9f/0p3iOuAIHjNOSdXG8QWOCKMV86UDtJm+0UhL91j
        I9iEcjwwcjaaSD5oZPOPew8uI9QbukxxXSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OHM0YF7wivgY for <linux-ide@vger.kernel.org>;
        Sun, 12 Feb 2023 15:11:52 -0800 (PST)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PFNX74mCfz1RvLy;
        Sun, 12 Feb 2023 15:11:51 -0800 (PST)
Message-ID: <bcff90ce-a410-6938-b1f7-c9b2dc89f29b@opensource.wdc.com>
Date:   Mon, 13 Feb 2023 08:11:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <f9781af4-667b-197b-807d-970df77286b6@opensource.wdc.com>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
 <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
 <6936c460663c956b5c77215eeef140d7@psihoexpert.ro>
 <235d8863945fb1da23c1e7b74831db38@psihoexpert.ro>
 <5ed3c6c0b6ca71ad45d269e615c33622@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5ed3c6c0b6ca71ad45d269e615c33622@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/12/23 22:14, marius@psihoexpert.ro wrote:
> February 9, 2023 1:00 AM, "Damien Le Moal"
> <damien.lemoal@opensource.wdc.com> wrote:
> 
>> Thanks. Did you test the other LTS 6.1 kernel too ? The patch was
>> backported there too.
>> 
>> -- Damien Le Moal Western Digital Research
> 
> 
> I tested the patch applied to github tags "v6.1" and "v5.15". They both
> work fine.
> 
> I build another OpenWrt image and it doesn't work. I don't know why and
> it's difficult to add modifications into OpenWrt kernel, because the
> kernel sources don't persist. The build system erases everything,
> unpacks fresh kernel sources and then patches them. To make any
> modification I have to add .diff files into the patches dir and build
> again, write the new firmware into the router flash, test, etc. It's
> very slow. I think I'm going to leave it as it is and limit the speed
> from the kernel command line until OpenWrt updates the kernel.

OK. Sounds good. Thanks a lot for testing.

> 
> Thank you for your help. Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

