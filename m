Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054AEC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Dec 2021 01:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhLQBAD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:00:03 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11865 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhLQBAD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Dec 2021 20:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639702802; x=1671238802;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0yRBvpo89/f5UoKDUEC1CHEtdB5nCGU+Pwkpf6FHWv0=;
  b=h3sgXT3zNWVjCFn4lMWZJkjFq2lABWMnENuj4JXz4iusS76iquxKaGBR
   i/PJBkZ6jlQkUB0RxA6DhDhejgyzujgYaKNmbUlXVl7LG9jgL44W6Jig2
   zsrI/hXf+XVSZcAJ2Z7j+NE6yvY/Sejuk9x2fn2IRNL7CICuFzlikJjFF
   4uhBiQpKX9dWA7MucukERKFYMSed4n3OcmlkRn3cJ+fC5cWimPgi5jHeg
   iYRR9L41mzhsT43sV+uG2+vNHaNsUsjDEO1c2KDedFZQ8Lqwqein17x8h
   6biDd3X1REfERa247lMlYIdkeX0oPjvvfeKU21MhR4te8W2kN2RmbiLr5
   A==;
X-IronPort-AV: E=Sophos;i="5.88,212,1635177600"; 
   d="scan'208";a="193258341"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 09:00:02 +0800
IronPort-SDR: yLuA/FdAsNH41Up3dTgfxrj6nNxEUYQDmWtiGUXgmDqQWXPPKHbKuqRYpqockHdq0L6q5L6btq
 Fe8cXCTEnliCXTJcJC1j3Xhr6NLCj4v34+3TksQme36aCdwk3/o+cLphmDj4GTgCLC3bVEW+dl
 b64UESIkn/Keb80Km4u2u7sQ2SZVEPyCd3jk1ImUWbH19lx53nDXJu9/d2Pd0vhxT8MULNpTjb
 XtjAlQwsnAJPVDPaIq0HNX9+cCiFQ8VRiMO2AJ2m466TsJIBSeYk7NGIC8uwo8etawNtKYad3Y
 ySCur337YWjsx0KhQUaIsjly
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:34:23 -0800
IronPort-SDR: y+CO3dkpsTxIUEnM01VEWwxOtCKGqISiOUO3WNEFeUkA9dKMOVlTkO8/7olN4eVjjQjU/6ofMO
 a7jVS9wnOC60Rf8JnwcKF9mWquolkTDD/AgLgCO7f8lfZrCHFxwJGSz00vTBMcVz5LUROOJ54T
 DfdaOWjKtKrIsd9g46CR/7LSz6knsVipP8/5mV3mxnKuJ/G45+E/WYyqnm/eWWvZud0we/6aU0
 zg2UYAF6vqfuv+8curY5qNZR0uTZil1Yd7BHdUNf+Pt+JzpvGF3XFPIyCm/6ET2T9VQQ0fMPDw
 ozE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:00:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JFVyB1qBqz1Rvlf
        for <linux-ide@vger.kernel.org>; Thu, 16 Dec 2021 17:00:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639702801; x=1642294802; bh=0yRBvpo89/f5UoKDUEC1CHEtdB5nCGU+Pwk
        pf6FHWv0=; b=sYbLODLOr5owqFg7fcE0ALMBb/EUU8SnuARwK3Baq2uib2+flCO
        otdEm8KPZAIfHv0lrCoD5/XG3TFdYw36twLS+JJlJ8gWbiCH7Awfw8J6OGIdUlLj
        UafVcqRGcjGz3HdmzQDI5+1xGPtWfJ7xDc57e/Jxwr77QzZITSr+tWf8bYDSazvA
        MZ6RhF/D2drV7iW8OnoQW6UHUazEErxYbrduQhHGnqAmTaYHX8q1caMfCOBwgi5D
        EGMjl24qcz0hVOy4NsazYmLevJG9IGr2USywbfjNq4KhdzZ5Uph3xxPpTrUxGiGS
        3nGxuQotyUWuUcVPuSxe28PRQSvpVJMmHcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rzLuLaWRV4ui for <linux-ide@vger.kernel.org>;
        Thu, 16 Dec 2021 17:00:01 -0800 (PST)
Received: from [10.225.163.18] (unknown [10.225.163.18])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JFVy92CMVz1RtVG;
        Thu, 16 Dec 2021 17:00:01 -0800 (PST)
Message-ID: <45b69051-92be-78ad-c75e-75cce98e5abb@opensource.wdc.com>
Date:   Fri, 17 Dec 2021 10:00:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 2/3] ata: sata_dwc_460ex: Use temporary variable for
 struct device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
References: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
 <20211209143519.60498-2-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211209143519.60498-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/21 23:35, Andy Shevchenko wrote:
> Use temporary variable for struct device to make code neater.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied all 3 patche to for-5.17.

Hannes,

Please rebase your v3 series on that branch.
(if possible, I would like to get it soon, pleasse !)


-- 
Damien Le Moal
Western Digital Research
