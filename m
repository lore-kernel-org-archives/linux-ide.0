Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DAAC7618E
	for <linux-ide@archiver.kernel.org>; Wed, 15 Mar 2023 07:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjCOHPN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Mar 2023 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCOHPL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2023 03:15:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319ED211E5
        for <linux-ide@vger.kernel.org>; Wed, 15 Mar 2023 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678864510; x=1710400510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ECXmvGTKdjS+g5nINwMxwrG3TsMXwaXm1L9ClyYuU+4=;
  b=CxCaYKFRojLWbjkIl7AeMGuQp3Ghka1UQcmFTcDXq6VZepyYPZ71e34z
   qJN/F3l72DKPWY4zCnNzPPr2pMSRjCH3QF4DaXRVuTxpRe5cwtz15Pp9w
   S9HbSPHuiYWpYJ0y1b6X43udBuFjsXKcS6AhddM7Vnhg3IWacaCSCPJOm
   P8225WGLAFeefHTdVj9aQt39IfAAAIyzC1og9sfShd/3WfGwTS9AZpVPS
   KwZxuP0kIg3MmDPx8Lv/lNZPeXHQUaEeGmCjdLZo5ho5M5PfcCjL/EiWV
   NAr+Ecl7y/ExRoooKYD9/gv10JH0Llr8wOd03XjLmne4TJeqm6uWbkhVm
   g==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223952358"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 15:15:07 +0800
IronPort-SDR: G7t7lT7vw/6Ngs58lXLom2tYClUj1VMxWIFd3oT2pcv+3VEWBPdIwSDHf5vtvE/Vmapsw+IUJU
 WKafZNT9RPFqG/bbeFYQEfyIzmJ6H9ocQ/rVABP4mjeVchSxXJc4R6etfWEh7s/ud0g3+1Hsjy
 7GiKR1X+1SdRl+kTMd6wgxbV/coIynYQOqw/FdiNeyq2IJY3pt+jApoz6AIOhOadZom1cLGb3W
 oGJ8wAlP5WXpT/QAOQnTSU3XeF9R/ytxMHIuaq6p8MVTFCP967rtXAsZvJaAXkTCXNSLxEn+N8
 CVQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 23:31:34 -0700
IronPort-SDR: Cg4nExgUS44Ao92WwHMdXDJ4jLXc0hKT6fj+j4JYMCJPl7o3gp8tcnDRgxqSyEUjP+3wFvNgRL
 eNP5uHTNZleIVqH4vEjVa1jj+guQXWS6qiQRX67l7v3hy3NRp5fYMfE6FlrPcGCjlH6dK4AjGA
 nSVVBabtwUOvRs5K+z97i+JYd5pfDbzYPFXx8DBGqHB6OW0CeuLtzFNi37BEGoXcPtKpdokVVZ
 Pib2PSVd7kgkfCQKb/jvGYSLGviUP4EeTsb/U5mQWOdigu+9UpfGc3efjn3nLCCI+Zpenpaza0
 cqY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 00:15:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc1qt6sCmz1RtW3
        for <linux-ide@vger.kernel.org>; Wed, 15 Mar 2023 00:15:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678864505; x=1681456506; bh=ECXmvGTKdjS+g5nINwMxwrG3TsMXwaXm1L9
        ClyYuU+4=; b=GWScIxt5MSCwyNJaxKaaEEtsmxiAc0PYy89tdGXtLpfIHq5QdyD
        NQObiyUoid1/ks9Txugu9YwZSR9nE1xSQmPhGCcOxnozFKeP5nH0h3Fa7ACOLt64
        L2XKljMl2F5pgV7bJ1O1p9HC5N06fX9uyOdawD08C9E4PDWqXHywEGb+g1Ibd6eI
        09y1+uqVd5gnrUxxtqKKig1Rh1UXfAwhYREgzQvJarNjSl3L73h5GB5yY5V4exTW
        zoqsD9Ebe1rqlAuvePtHiPFwmeLsk3ZIi3K+f2b3tuZc7Or0zTKhNi1Pm8LEH1At
        hJKOVcNFt6YDujQfjTfmnVym4wEUq+XQj6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IXz0CqGGsm-I for <linux-ide@vger.kernel.org>;
        Wed, 15 Mar 2023 00:15:05 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc1qq0zrxz1RtVm;
        Wed, 15 Mar 2023 00:15:03 -0700 (PDT)
Message-ID: <47046373-3d35-5f40-e0f4-6352f95fa8b4@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 16:15:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
 <7453aba3-9f2a-4723-3039-a85652883b48@opensource.wdc.com>
 <e31e32f0-86bf-4178-afad-b731ea49e673@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e31e32f0-86bf-4178-afad-b731ea49e673@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/23 15:46, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 02:23, Damien Le Moal wrote:
>> On 3/14/23 21:11, Niklas Schnelle wrote:
>>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>>> not being declared. We thus need to add HAS_IOPORT as dependency for
>>> those drivers using them.
>>
>> I do not see HAS_IOPORT=y defined anywhere in 6.3-rc. Is that in linux-next ?
>> There is a HAS_IOPORT_MAP, but I guess it is different.
> 
> It's defined in patch 1 of the series, so the later patches
> can't be applied into subsystem trees without that.
> 
> We can either merge patch 1 as a preparation first, or keep it
> all together as a series.

Got it. Either is fine with me. To allow option 2, I will send my ack.
Thanks !

> 
>       Arnd

-- 
Damien Le Moal
Western Digital Research

