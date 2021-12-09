Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46656C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 08:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhLIIOg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:14:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59034 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbhLIIOg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 03:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639037462; x=1670573462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UzqLDThfCcMJGIFucqDQlD45hOw06aRi74VKNXQ3TV4=;
  b=IfEl2vmCEKLL+4ZvmAmZxIJLDShCHdFv3nj3COiXUwZfXSGQgnc9ZJbH
   fXfLr1NE3q+ppkCmFtmtTDIfw+yzJeGH7Azq4O6I7FM78OBp0ibA5TTrA
   ZJiQ6cvLR0nvE13TRwD9LmWGjM1GAcBfonbQNFPRvvGOIm3Ex34fz0LWM
   CST94mdV/yDbgyKY+EpzBCRlIBZiJTx2rKyopdbRX6i+7SPjdWvdzS3g1
   CM5jIDBuDcswiqa9sBlh7TRspftOl14xbIjwZv1YMDuPFoHdn0ipqnIGB
   1F8iXEelL7tj5Lu78WFT+PWxFLv9pL1AlHwNrT+wxc0WpIgF44DD+rxJM
   g==;
X-IronPort-AV: E=Sophos;i="5.88,191,1635177600"; 
   d="scan'208";a="187823639"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 16:11:01 +0800
IronPort-SDR: W8WuAqrGAZvfIJl/oo4d0qeaSTsGH3XMZUeOaY56qMFPjKdJOwDTsJuiXpKsc6UZpn5DYejCVD
 twn2z6BYiciUTgniqZcN1LtLpcjf9mq/ttq0/F+h6jkzzwTv65mwpxeSN9jUzz4CqDbQIrsa1D
 FvTArt7Ye5DFX8zASsatRLo1SGTJ5hF5XaL6a1pxj7LD3fdS++Oq0T69EgVjZykqOcp8Cmc2Cq
 755zDJytw5XEIX626iWIhAM68wcnreK0v7zn9R1QoPxIfSkDUSoP2Y40pR4cJUxn/vhtgCrTBC
 wRidvWGA3CmDwIi6FoIKfo1B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 23:45:36 -0800
IronPort-SDR: mtQhk78Xr0eHJhN2udNApsU938ki4hhv+g5yuf9X21VlycG9ptvRr1XS3v4jUe1B5Y4xX8Ly52
 ek9SW2L3e3p0ao1XMMcKrW/LqPICqbzJkr5kpt6Igh6GeQOoffABxFe6+4yxA42fTuHFvfkSLI
 LQjLNJZIAhbXAnHbDiHtqcMHYYbByAOh1IoTsVR0Hgy53OsN3eqcGIuQcUvd/13mn9BjeK1hLy
 fuQBp0okDNo7bc6WqaIwGcPvGSOV/zyEdHkv1mJX2dHGEzTFm+SmGDuzgPBeI7Bu8ef82U3zTZ
 obE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 00:11:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8mvB68Frz1RvTh
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 00:11:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639037462; x=1641629463; bh=UzqLDThfCcMJGIFucqDQlD45hOw06aRi74V
        KNXQ3TV4=; b=sGLhpoGWQaoxJFSgfDaz50VO1aaXS8czAlo4Q95sdSVNhmjFros
        XeS2XC32PWD9UJ5R/ALDNtaf1PT3VUgSuLFDxg0+z5En7nBvHmPXC9nfelBQRaJR
        CK089MavKk/Nl/yXMhAVXETcBDFJLIVJpvNFNZuM8DDAWHvFun6A8eZSVm97SWb3
        xMPZ+ZbEjB9J8yLn8mUWLqvO4mwDKciO0KIMZ/2XHJwKCfe2OZiFP+mboOc1Uc1a
        8Upgrd8MpByvlAgj8wvvZWsYSazoEfQJKcS5VwZVhAOlj9DeIGLqfND4Z3EFXJCo
        ci2FdQC3KbEVtG98hwYCahCABvAJlzGfYUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5m5PCtkpuUjg for <linux-ide@vger.kernel.org>;
        Thu,  9 Dec 2021 00:11:02 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8mv95GG2z1RtVG;
        Thu,  9 Dec 2021 00:11:01 -0800 (PST)
Message-ID: <170895e3-a942-aee6-4e4f-7be464f1337a@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 17:10:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 05/73] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-6-hare@suse.de>
 <6fc0936f-d220-69c4-a76b-f68485a078bd@opensource.wdc.com>
 <c0891706-61c9-ff2d-c199-b15fde712040@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <c0891706-61c9-ff2d-c199-b15fde712040@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 16:17, Hannes Reinecke wrote:
> On 12/9/21 1:38 AM, Damien Le Moal wrote:
>> On 2021/12/09 1:31, Hannes Reinecke wrote:
>>> Implement module parameter 'pci_dump' and move the DPRINTK calls
>>> over to dev_printk().
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>   drivers/ata/sata_mv.c | 88 ++++++++++++++++++++++++-------------------
>>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>>> index cae4c1eab102..f0257685495f 100644
>>> --- a/drivers/ata/sata_mv.c
>>> +++ b/drivers/ata/sata_mv.c
>>> @@ -83,6 +83,10 @@ module_param(irq_coalescing_usecs, int, S_IRUGO);
>>>   MODULE_PARM_DESC(irq_coalescing_usecs,
>>>   		 "IRQ coalescing time threshold in usecs");
>>>   
>>> +static int pci_dump;
>>> +module_param(pci_dump, int, S_IRUGO);
>>> +MODULE_PARM_DESC(pci_dump, "Enable dumping of PCI registers on error");
>>> +
>>>   enum {
>>>   	/* BAR's are enumerated in terms of pci_resource_start() terms */
>>>   	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
>>> @@ -1248,42 +1252,43 @@ static int mv_stop_edma(struct ata_port *ap)
>>>   	return err;
>>>   }
>>>   
>>> -#ifdef ATA_DEBUG
>>> -static void mv_dump_mem(void __iomem *start, unsigned bytes)
>>> +static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>>>   {
>>> -	int b, w;
>>> +	int b, w, o;
>>> +	unsigned char linebuf[38];
>>> +
>>>   	for (b = 0; b < bytes; ) {
>>> -		DPRINTK("%p: ", start + b);
>>> -		for (w = 0; b < bytes && w < 4; w++) {
>>> -			printk("%08x ", readl(start + b));
>>> +		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>>> +			o += snprintf(linebuf + o, 38 - o,
>>> +				      "%08x ", readl(start + b));
>>>   			b += sizeof(u32);
>>>   		}
>>> -		printk("\n");
>>> +		dev_printk(KERN_DEBUG, dev, "%s: %p: %s\n",
>>> +			   __func__, start + b, linebuf);
>>
>> Why not dev_dbg() ? Same comment for all the prints below.
>>
> Because the entire thing is encapsulated by the 'pci_dump' parameter, ie 
> it'll be only ever called when 'pci_dump' is set.
> So it feels redundant to require both, 'pci_dump' _and_ dynamic debugging.
> 
> But I can move it over to dynamic debugging and kill the pci_dump parameter.

That sounds simpler to me.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
