Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF71C00140
	for <linux-ide@archiver.kernel.org>; Wed, 10 Aug 2022 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiHJN6D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiHJN6B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2022 09:58:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C5C6C116
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2022 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660139878; x=1691675878;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ClWPfH+Jd93qt/z4FiCRJJBeEEPfi5NziKxB5M5sGPk=;
  b=FL6O0SPyRACivtM5ZDraHOeS6oqRIh0buJHiMpP2XiZrkKli+aFfgLax
   3HtyJVGY282H0CAEUuU5fKlbbA3fl5zXVceJdyk2Dm+gAulGNKz+3kGOL
   RH8EimoyXql2rqJfImYDwZhjZAoYzavJF+wwawSw/eM3kIiIBRubKXIrQ
   COMzHD6qE8CAL7jLbIULC2/LXWtQvmzk5OyYNcIqPji0953gjr0M6vFf2
   OB+6TfmFj0Kwb72HW+5g5XzshEJuuQKr91BEhWuZujNU2iyN9DWQkT/yH
   7p2h04F81eLLa4HzmDUxyURMGar6F/dvx1nCt4XADkkb/aXOdUoYRSLe6
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="206843687"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2022 21:57:57 +0800
IronPort-SDR: BjX3Mavsy6RJK2j4Er1V+45qjce37ZpvLLA7K6+EJ/cOsBvZ+x3V/AfC3yTlEOCt43bTDUhfg+
 8hOx/NfBbSqOttN7EzB115sugTjvGJlcJ3Urn6yCVrDFM88FcIh8VYEwbecoEQ+gLram3CKK+f
 2r2kz7a40ctGZdAhscenEWvrn4T2MJ75RcepZF3fr126eYXaQfPqeYCMV0a+d5UJWQMTqOKG7h
 OzhX8t4HFJ0b7z7Xdd6puOlnHkzRfBlCv83TctBdPCGmJUs16/aFlQBt/xQzxa2bkUBiqvMLEV
 cVyg2bvIZRxlNvMK6M3NI9w4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:18:53 -0700
IronPort-SDR: iZFM0DJDIUnILXKKlyraDr5lN9QCQM7bYP6iGdoaYTGcO3VQumFmVnq0N9M4/MuAtWReeYQ449
 MDpeDAW/e3DQ4P6ZmmiuXRvdTCl4pBwRKUREfNZLFVIRUMGFvJyYFRxfsuGEMrSDzn1HF5O431
 1ZBrPrc6Qel2k1poSxuWanP1GuUUzLAVgPPs8TKCEMGmHhMbqCdGMVE25FDEZjSArHXtPpj5GE
 xs78z1keT3JGE5d4z/nK2Wu46jL0RKwSwxyY7TmIFPEhhtPe5wq4RmFYgL9RsAkB5XJWrJvIYg
 xq0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 06:57:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2s2s2v9Yz1Rwqy
        for <linux-ide@vger.kernel.org>; Wed, 10 Aug 2022 06:57:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660139876; x=1662731877; bh=ClWPfH+Jd93qt/z4FiCRJJBeEEPfi5NziKx
        B5M5sGPk=; b=ZV+zKlNpoD39suCWpwEcYuB/3MZlb0ERjRhMZuhlayBRa5A51aa
        bTMhqp5RXQe97OilXZA4z4IJkCpXb8SEdl36emCG+zT1gsIBQfetv90QA/oPH85A
        /OWZahkSW10yOkgvtI1i3gWieZG5MEo2rwqM71m0EeC52fPDjSS92bwHxuGO7qoT
        QZzlEdwVTuYt2dAcaDNlWhVOnG+Iy01+FddWXvhfVbXkkIJOUzhgT26hBFhVPWkG
        D1/40D0TsrO2a4tnCJhQzAaRI1PmM6iLSu3rBqLu6KMhUTarD2cru6vpxPOHtInM
        JqB5NyyTOPzpFMOiABuvx2q+1oSgP0oT1LA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dm2ix6DuS-Kb for <linux-ide@vger.kernel.org>;
        Wed, 10 Aug 2022 06:57:56 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2s2r0RJJz1RtVk;
        Wed, 10 Aug 2022 06:57:55 -0700 (PDT)
Message-ID: <b082ed3f-e2de-450f-acc6-9508d7689290@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 06:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <c4b45c0e06af473abe17e3471e1bb948@AcuMS.aculab.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c4b45c0e06af473abe17e3471e1bb948@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/09 8:16, David Laight wrote:
> ...
>>>> Without knowing what the device adapter is, hard to say where the problem is. I
>>>> suspect that with the patch applied, we may be ending up with a small default
>>>> max_sectors value, causing overhead due to more commands than necessary.
>>>>
>>>> Will check what I see with my test rig.
>>>
>>> As far as I can see, this patch should not make a difference unless the
>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>>
>> That is my hunch too, hence my question about which host driver is being used
>> for this test... That is not apparent from the problem report.
> 
> No one's fallen over the old problem and managed to limit
> the number of sectors in a read to the number of sectors
> in (IIRC) a 'multi sector' read that uses a single DMA burst?
> 
> Was always a good way of killing disk performance.
> 
> IIRC the maximum number of sectors for an ATA disk transfer is 255.

That is for super old pata/ide devices. Modern SATA/AHCI disks can do a lot more
than that with NCQ/DMA. The default max_sectors_kb for AHCI connected devices is
1280 KB = 2560 sectors, max_segments = 168 and max_segment_size = 65536 B, which
gives a reliable command size of at least 168 * 4096 = 688128 B (1344 sectors)
with 4KB page size architectures.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


-- 
Damien Le Moal
Western Digital Research
