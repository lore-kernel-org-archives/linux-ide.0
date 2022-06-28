Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C7CCA479
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jun 2022 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiF1JOf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiF1JOc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2022 05:14:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49A11C1D
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656407671; x=1687943671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhnPo7clhXk=;
  b=Uggs0G3bQHSTl8UzkQpVLsA1aAKbASdc+2MpxfpA+8BYd7lISHM0c9cu
   ggS9tajOVkaGCoDUWuwTvrgFp8fxCljc16wYkXSfYXARk4bPmilYmPuyz
   AESlpcL01yDjcLgua3sbdrE+Ed5wL8jEj6jv2Mvl2NMDD24djFFg0Te1G
   ZfE5c9JwtnWUooRsyvRA8BbT9I5fJB3VbxdBSLOZhwlRUGc1+lUtduPRD
   PyAI16cBs2a39YYbdfPBtZoTuD39WHgs/S7bckQq+dMcwi98evm/5fbmi
   9r0XBNBywPSL2IAQCl+hQTuPc96n/cEZU/bT8e1OZ0JjE1IYiGjZ1pJD9
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="202954159"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 17:14:30 +0800
IronPort-SDR: YbatYATIiwtqqL7NCIusKt6QdjzIS+/awhb0ksoUHL9+/r5xrQlOkAptGb6q2UvvIT++/KdVGq
 oppG07g1vJ8iQSJzcE94add2sE5TbesNXP6u8ok0oiNDZ04O348JPVeLT/Sby5xfKujNw6/uhF
 thUBkMsVMugyuRVOoPycDN7MHwxnkE3fuzamu36vEELIXlEfVgn0uAqe2MRZd3uNFOrnTUzmWj
 X5E1TUyKItkTUQlXn8qqlebRKC7I6PWjkTmwRS12TI8VCf6kQQRVJL3AUxFu2DiifboKfUB1ha
 UfuFIDjjq4NnGctguIpB7kdH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 01:32:10 -0700
IronPort-SDR: /Lo6cYX0j+4QPBlt/+hWPDaG9Wls3NMITprSbxgzTI21FWpwu32XwHIzcd6A8ILJGA7VtTDLpo
 AjZWL9ney8TPWs83Ogz3ru3rPQ8Wamdyh8Qtvlmf4tnvpPfBExsL7geGu9boe58syFhKOH5ils
 Mj3pJ+gC/sfVxvBCgxDSqDN3ayQEyaK5WsQE8D0Uo8vGNjnbrbwWV0IG4UXnDfhgTDaiCSKKkQ
 LuOf9+pEOn/IMYsk/fx7DpT1mM5G5Q/M2yjgw+aApw++LAmel0sIdGsp52O3ZM288qAqxRG48U
 X3A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 02:14:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXJnd4qXnz1Rwqy
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 02:14:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656407668; x=1658999669; bh=m7ZvDnvdd5GvaUmk2CDtIh9qIt0xOE1YKhn
        Po7clhXk=; b=fonT/uY7iPNzTi3ZQtgIXYc1C2nSzN3i9+X+P29x59EXxdjpUaE
        D6Sw7APsvVE7Jg/+qJ3kMMxTcurmh9i+TVhHbGhJOJHMxgsVRnjqDQ1hHH61ZDqE
        olMV5nY6BxIQ1v9956RDQxPObZ2iTz2PB/L6jp5SiKoL8osveKfZyeBhOPF/S9aJ
        jsAP0UCOZbVBVpaL/SH/3Fp2zaozwb71DqJw2OtzEaNPTQ+2FqtHqb9jGZFACewu
        iitZYNmam4gs7SQk8cQeJAOAwRB285P2k62pEWk7Nwsf7zHcyXaSq33gUYGFIqjc
        C5muLk3LwxS2tb70g9gT5bewj0wNJ57IKOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YF_dUL-9oPaG for <linux-ide@vger.kernel.org>;
        Tue, 28 Jun 2022 02:14:28 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXJnZ4JQfz1RtVk;
        Tue, 28 Jun 2022 02:14:26 -0700 (PDT)
Message-ID: <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
Date:   Tue, 28 Jun 2022 18:14:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/28/22 16:54, John Garry wrote:
> On 28/06/2022 00:24, Damien Le Moal wrote:
>> On 6/28/22 00:25, John Garry wrote:
>>> ATA devices (struct ata_device) have a max_sectors field which is
>>> configured internally in libata. This is then used to (re)configure the
>>> associated sdev request queue max_sectors value from how it is earlier set
>>> in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
>>> according to shost limits, which includes host DMA mapping limits.
>>>
>>> Cap the ata_device max_sectors according to shost->max_sectors to respect
>>> this shost limit.
>>>
>>> Signed-off-by: John Garry<john.garry@huawei.com>
>>> Acked-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
>> Nit: please change the patch title to "ata: libata-scsi: Cap ..."
>>
> 
> ok, but it's going to be an even longer title :)
> 
> BTW, this patch has no real dependency on the rest of the series, so 
> could be taken separately if you prefer.

Sure, you can send it separately. Adding it through the scsi tree is fine too.

> 
> Thanks,
> John


-- 
Damien Le Moal
Western Digital Research
