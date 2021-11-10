Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A2C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 10 Nov 2021 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6215961186
	for <linux-ide@archiver.kernel.org>; Wed, 10 Nov 2021 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhKJH4T (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Nov 2021 02:56:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35883 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhKJH4T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Nov 2021 02:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636530812; x=1668066812;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=FNfF11silYjYhy+i4KOJRZG2bsDsLJ4CVy3CT90O3Ww=;
  b=FvOoqDYMK1weWO3w4MVgQLB8ggprgQ5Xy4gAaMXEu3C/zkIlO7BxgDPb
   Vju2GnP8gdGRYj24GwUzeDGcBmKKqN4njJ4G4v8rUrmxolFLnqQTMTzWx
   LYK0OAEN7vZ8/PjM71WEuzDWUOoyCSVRheX24rJHwZxYJT+FxNKhfc2PQ
   kotrB1PIlmDd15Q1tDPB2Nj6WUiaoRPm8h77O+aiqjAT+StnaU9AbYhE/
   sWY8ZlnJF7oWj4f6/KwrKYYiDU4QfbPF+af7FapKFhdbXaTXN82wTCI03
   Etu0eQCqQfooKdDzQW2iu7qLyQqXGMUk9ToJT/sZLIU8+kDjwRC7Xa8i8
   g==;
X-IronPort-AV: E=Sophos;i="5.87,223,1631548800"; 
   d="scan'208";a="297010312"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2021 15:53:32 +0800
IronPort-SDR: 3wXTA8Z+Ky6PStgK3DUwcHmLUj8BnSZxacBRf1NolF2isQk+Yb1sXyXw3VPKwpe+wfhTDlP/3k
 Tst0fjKArqLiiYrOuJvRqGpkA/LlmcHFAnxIKx7hw45IJAFK9x3WFauyEKL7nzgoS4PN//4tMX
 dDNGJT+Swa+Uwo4Fh0pVlGyZiCe8v5lXBnMZ1ObNsYPbptwigrfG6TOGq3emoJm3YR42uWNiX7
 j4fe9FgBkyEyuot2YZGqGWFu6nyVh6oX0a0w6fEujq07rZ//CFRMvbnQgvy+pTyRivjBpEt717
 w7RmdXXQL7K9AE12e9o0AAFq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 23:27:10 -0800
IronPort-SDR: S5uKsSQ1gwroS2NInra2lZ1v/kbRwRjhSss1K4rDRVQ4aTcVc3Hv13rzHIK+vUcHPbZIcgQy/4
 eSeU17fuuaeSscm2S3qbGVgyRxsLOqrPB97XJ/LBvmsMi7OviaCC4It0EbKMzGx3ZFecx8YyiY
 buAtvv7ZQ/B+9pncFUSevXdQmNFsK54o71oFLIB1KOilRXlnRmxh1iTmrhFH6p4VA7cpgkCW/e
 8ryqqU0tMOFbbCpald05RccvJx/J2HRiMyYPJ9gBw1e3Sj0TS2mGIWk/GTPQ02TH+cSs5NAncH
 o6Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 23:53:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HpxtM3Xs4z1RtVm
        for <linux-ide@vger.kernel.org>; Tue,  9 Nov 2021 23:53:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636530810; x=1639122811; bh=FNfF11silYjYhy+i4KOJRZG2bsDsLJ4CVy3
        CT90O3Ww=; b=fjlfxSlman9SaCB0Giz2m8Rn7zPWXBd+/1LUbk8i1yI1LKA/l9l
        JH77arL3KLEM3Kf7IYfD0g26MwtscQgKmuIBIorNkaY/FzoHLmNdXLNTCRlMw08K
        6GZlIrfMbgNpalAHSCawYojUgDlcPe4sKmxfwOc5RkRS89kOar/faasF1u7oBQ21
        FPImVk23VEA85M/z66vL9Fu7OVBR4tad53auzNKv+Ac4DjVCoVXCqiWtzo43WAn1
        Yd1Bqzt+gNQPkLWq00NmvmuTpSVQHf3XhOMe5s5OWp4oLvQBX5p5Ij9HHE50YNGK
        3rvUz8N9nOTK4G5kr10N5IeZLl7tRbKJE9g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IwYWlpvHVY9N for <linux-ide@vger.kernel.org>;
        Tue,  9 Nov 2021 23:53:30 -0800 (PST)
Received: from [10.89.81.216] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.216])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HpxtL2MBHz1RtVl;
        Tue,  9 Nov 2021 23:53:30 -0800 (PST)
Message-ID: <ecdd67c8-03f6-0e68-03aa-8a6d9494f8bf@opensource.wdc.com>
Date:   Wed, 10 Nov 2021 16:53:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] libata: add horkage for missing Identify Device log
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org
References: <20211108235723.408711-1-damien.lemoal@opensource.wdc.com>
 <YYo3N/dwJmOxCBHE@infradead.org>
 <1030065c-1ec2-991e-10a0-c01231b9b664@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1030065c-1ec2-991e-10a0-c01231b9b664@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/10 15:17, Damien Le Moal wrote:
> On 2021/11/09 17:54, Christoph Hellwig wrote:
>> On Tue, Nov 09, 2021 at 08:57:23AM +0900, Damien Le Moal wrote:
>>> ACS defines the ATA Identify Device Data log as mandatory. A warning
>>> message currently signals to the user if a device does not report
>>> supporting this log page in the log directory page. However, it is
>>> useless to constantly access the log directory and warn about this lack
>>> of support once we have discovered that the device does not support
>>> this mandatory log page.
>>>
>>> Introduce the horkage flag ATA_HORKAGE_NO_ID_DEV_LOG to mark a device as
>>> lacking support for the Identify Device Data log page. Set this flag
>>> when ata_log_supported() returns false in ata_identify_page_supported().
>>> The warning is printed only once on device scan and the log directory
>>> not accessed again to test for Identify Device Data log page support.
>>
>> Should we also just set it by default for older devices?  I'd need to
>> look up when it was introduced, but I think it is a somewhat recent
>> addition.
> 
> It is marked as mandatory at least since ACS-3.
> Need to check before that. Will do.

I checked: The IDENTIFY DEVICE data log was introduced as mandatory in ACS-3
(ATA version 10 in IDENTIFY word 80). This log is not defined in ACS-2 and
earlier specs (ATA version 9 and before), but I see plenty of ATA-9 drives that
have this log implemented.

So I think the patch is OK and only needs the warning being conditional on ATA
version being equal to or higher than 10.

Sending v2.

-- 
Damien Le Moal
Western Digital Research
