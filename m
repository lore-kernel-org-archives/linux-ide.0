Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D168C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 23 May 2022 07:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiEWHdt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 May 2022 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiEWHdP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2022 03:33:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97FCB44
        for <linux-ide@vger.kernel.org>; Mon, 23 May 2022 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653291193; x=1684827193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LJ8/2FSDHURz0Zuhe/Qx3SaImInSLYq6abN68q4sCnc=;
  b=cOAcQZ8q+cCQcKvWA8Kh3C6gvh9AQoe8JVmkD1Xqdhu1AzBdhTsSyqPg
   4zaDAeJmVRljZ4lz6zVX1qnQtXgQyR395M42P6jZWexYZ2I3hOtT0l49s
   ywDmjA9xQL2R77Dp+EW5TRhz6Kx9KN0KBajxzGFJeDN18/c5T00qO5kls
   KUbkz6JLwRAhUOkWMf0Uw+wHJynHLiyM4S2dR/zUSHTHftqnFuGi3icEG
   1wRrqngMTljIq1XktM8surlIlE49xgWHJhfyVD59DS0MA9t/+GTIGym+k
   Mnrm/4o9mOXYZ788VNTIniXgJtxsFZPt6UhlpOtl56zg6Mdus+H6WMOCG
   A==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; 
   d="scan'208";a="199924556"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:33:12 +0800
IronPort-SDR: z+BwKsdYjswNTVN6DHhsXe8c+7gi2RR49Z5eifgkdteL5g9TEMs5XxvHN6KO+gG3gzmi2rVIk2
 ARF3befJj7wC2XSwyEDrMKaDWN63+FgfDHVjCM5MoAlc2VkVWG3aMst4h2Pstut0AsE3EHbc02
 g7vQHyC2vBgR5Y4n/+avQRivmG5ca9GnnubBO+FgjmXVxKE4O/+e65fL3/s7HK/hxRHSSN6aPA
 3FJ1HgTTpGkVweEfiesBBKzWIU2/tam4EQzUKVmS0RB4li0wS1VPJVECiPmMnhRKgBDxl8WMHo
 MflCNaTfVNwThnsRUbTKAcin
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 23:52:45 -0700
IronPort-SDR: nOEi2A+wZx6lQXEO0aB3b/P61BcEgf/0+vm00S6E9/D/gP2sQHC+zXZUY6Qa3QoKehOz6mznHx
 Sg/j1Bst8nZUHeUXmDw8+ZIBMUcHSI3t9syI4aUBv7IwsT++vPo5/KFEeY0yV3eZMHqzAH6n0d
 h4qVmUrZCT56cCjsNM7DB3KuJJqIWHYO4cEFKb06LLHhmu04eu/ZzwrzpSmzV/j9xDIseLs5xh
 41Cwn6h4so7LkBJt2hSrpQu9edm0DmrOUweYeLeBNYmR+TbyoWl89uqGR0KA7HKiC+EOjml7qC
 hZQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2022 00:33:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68FM5DLtz1SVp2
        for <linux-ide@vger.kernel.org>; Mon, 23 May 2022 00:33:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653291190; x=1655883191; bh=LJ8/2FSDHURz0Zuhe/Qx3SaImInSLYq6abN
        68q4sCnc=; b=fbzRa9DHE20CwXRkfGCjdgl4Zx6hwQ1fI7gSJy9Vj9vrbyA+aoA
        Rw4pr+X1sm88OhK0n/MDZUOKzRM6+1XUPow3v38BNiuuWUVEjPBAs9JimtP0J1oa
        5enJzvjcWir1XMEjtGp0JTqRmXwbjRULL5fIoXkiLjsspkVa4jgTQ05LmTmyHnhR
        tAowXU1Vzw58oSBt7G62IYzQ0lpP7zWaJj51+rCw1WCpuu18fMc5yugLgsQ/CeJU
        id9aSljXegV2ggC4TO5fIgUiEHK+NcWIdCLYtpiMwg5m/PynMdAGy7CWYAxCpc+z
        CjoJdVpQWLUB4jwo/6+Bk7Cb0jybiv+eikw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MyNF_S8fLM_C for <linux-ide@vger.kernel.org>;
        Mon, 23 May 2022 00:33:10 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68FJ4nptz1Rvlc;
        Mon, 23 May 2022 00:33:08 -0700 (PDT)
Message-ID: <6175fe49-f3e2-bfcb-2b97-b58763f1cf0e@opensource.wdc.com>
Date:   Mon, 23 May 2022 16:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
 <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
 <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/23 15:53, John Garry wrote:
> On 21/05/2022 00:30, Damien Le Moal wrote:
>>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>>> index f69b77cbf538..a3ae6345473b 100644
>>> --- a/drivers/scsi/hosts.c
>>> +++ b/drivers/scsi/hosts.c
>>> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>>   				   shost->can_queue);
>>>   
> 
> Hi Damien,
> 
>>> +	if (dma_dev->dma_mask) {
>>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>>> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
>>> +	}
>> Nit: you could drop the curly brackets here.
> 
> Some people prefer this style - multi-line statements have curly 
> brackets, while single-line statements conform to the official coding 
> style (and don't use brackets).

OK.

> 
> I'll just stick with what we have unless there is a consensus to change.
> 
> Thanks,
> John
> 
>>
>>> +
>>>   	error = scsi_init_sense_cache(shost);
>>>   	if (error)
>>>   		goto fail;
> 


-- 
Damien Le Moal
Western Digital Research
