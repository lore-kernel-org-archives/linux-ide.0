Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C7C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 09:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiCRJfc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiCRJfa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 05:35:30 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777EC9D0D1
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647596050; x=1679132050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7d46xlMU7lvJI4zXjUOW03yg1qxd15Ms+gG5FzQwjcE=;
  b=TeXhcD5Y9H03T6X/e91oTyM50rwJj+1nHSDrKLgi9NxUwG5sfTzATzLf
   uxhIf2Q53Ue2L7fWq7yGzQMvzSzPqLXdx4uj2ZUUY5vlCEJDCYZi44hP7
   LQ/w6odB0AGGof4T8/V9vbQ13mvHFFEm1nB+oFTrjuezGRnf6TyqXKghf
   HIYr8l111Gj8f9Etvpv/cX0nJJLTvWZxael7gMhRYv/1x0OfDBkaQvjm9
   R3o9PkFJqgInjszBgwxKeAgeDQI/+XnwwJ1gV2PXlgNy5hptaRGWV2SCX
   iueih2j+m1JYBqnVWtjCkTVb4+cnZ/1n1KLe2uLshGrxZHVcYwfRbjOVI
   g==;
X-IronPort-AV: E=Sophos;i="5.90,191,1643644800"; 
   d="scan'208";a="196622628"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2022 17:34:09 +0800
IronPort-SDR: 2irRVZBiZelfhJ0ziuF/8HAql/UQT4oHg8xWX1vUeDxeHVJWPghJjT+aX321bWYkr9XHcX6FAC
 6MxvLFaSuOhIK5ZkaGXyFFeb/H77bq7ogiJlrxsYi7RTI1ORVc5wzjx99g+rxIR+WjAelZFsRT
 yDlXNRXGJM7DXjYHRIUBT0I3DAp8mOZg5F503gJCm5V9by1lMpwlowoCYipuvHhWvBhWqyl2na
 0ZgBbaidrers7N9gGRyYCaB3R5QVp/dUXc8KVS5MZDMXHgEfMHxc1HQ69XDt4ui2z9HZYV2NqF
 uFkHuDeMuedK34CpNeVA3LPU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:06:10 -0700
IronPort-SDR: hUODSKqdQZYfv5tC0zRWN3P1Ya6+odKR1BwjUcGcV3pVxP0rQyrwmWCsOnKR2uyI5zHhxEX5br
 l7VpVIETwQZhMNkZs+9a5G8PcUwkkxPd9psB91l/sIk6jOk3u1R5mKxa/Lun3YvGQFUNNHgSeP
 ZKbaA2c1qT6WVOSZ2kp18qqdjAfn0X7ryqz1iH8AvrcSxLg38RD4rrWJfHnq6xtmCO0Xx2Atqg
 +4oQihCbgB5duMq/eiBtoAAXZibBG1tX/U4wjosRBjjv6GAb18HGQNZJiV7uxpj+iqdafQ89Hf
 BHI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:34:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KKf3N1kK0z1SVp1
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:34:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647596047; x=1650188048; bh=7d46xlMU7lvJI4zXjUOW03yg1qxd15Ms+gG
        5FzQwjcE=; b=cSSUt9c5pvKSunvJsemP8sZdyBz9qU3FFH0u1P3kDv+I/pP7rge
        puIaZ+BgdJIjvjwABUst9QxAzCkDHYh/pU2m9oRc10b0OjdP52wYzukBrlY3p6QC
        jG0x84OD6PKgbc0vKeFxPrf7tsjZUvUMJNTV1UTe7BmbxHbUhGPUHLJRlhAk9Jf7
        iW1gUl/q8cSQRJ/yXapbtpSEf1pZoBhw7ooYqRCkDTBQRQSxAGQRD3lo1FlvYPTU
        1AlO5u9MHbDsOB8gDv8KSkWe9yiIy9/HY0sB5WOJDU89Y1x52IzCGSD94WqlkC6Y
        RmLrlIrTDdIySTCVAw+vR7frOx2SlZ/uqTA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RMmJIyLZwjbr for <linux-ide@vger.kernel.org>;
        Fri, 18 Mar 2022 02:34:07 -0700 (PDT)
Received: from [10.225.163.107] (unknown [10.225.163.107])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KKf3L4kMDz1Rvlx;
        Fri, 18 Mar 2022 02:34:06 -0700 (PDT)
Message-ID: <92c30932-3c4c-108e-1a84-26258a3c9d04@opensource.wdc.com>
Date:   Fri, 18 Mar 2022 18:34:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/18/22 18:03, Christian Lamparter wrote:
> the driver uses libata's "tag" values from in various arrays.
> Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
> the value of the SATA_DWC_QCMD_MAX needs to be bumped to 33.
> 
> Otherwise ATA_TAG_INTERNAL cause a crash like this:
> 
> | BUG: Kernel NULL pointer dereference at 0x00000000
> | Faulting instruction address: 0xc03ed4b8
> | Oops: Kernel access of bad area, sig: 11 [#1]
> | BE PAGE_SIZE=4K PowerPC 44x Platform
> | CPU: 0 PID: 362 Comm: scsi_eh_1 Not tainted 5.4.163 #0
> | NIP:  c03ed4b8 LR: c03d27e8 CTR: c03ed36c
> | REGS: cfa59950 TRAP: 0300   Not tainted  (5.4.163)
> | MSR:  00021000 <CE,ME>  CR: 42000222  XER: 00000000
> | DEAR: 00000000 ESR: 00000000
> | GPR00: c03d27e8 cfa59a08 cfa55fe0 00000000 0fa46bc0 [...]
> | [..]
> | NIP [c03ed4b8] sata_dwc_qc_issue+0x14c/0x254
> | LR [c03d27e8] ata_qc_issue+0x1c8/0x2dc
> | Call Trace:
> | [cfa59a08] [c003f4e0] __cancel_work_timer+0x124/0x194 (unreliable)
> | [cfa59a78] [c03d27e8] ata_qc_issue+0x1c8/0x2dc
> | [cfa59a98] [c03d2b3c] ata_exec_internal_sg+0x240/0x524
> | [cfa59b08] [c03d2e98] ata_exec_internal+0x78/0xe0
> | [cfa59b58] [c03d30fc] ata_read_log_page.part.38+0x1dc/0x204
> | [cfa59bc8] [c03d324c] ata_identify_page_supported+0x68/0x130
> | [...]
> 
> this is because sata_dwc_dma_xfer_complete() NULLs the
> dma_pending's next neighbour "chan" (a *dma_chan struct) in
> this '32' case right here (line ~735):
>> hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
> 
> Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
> the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
> causes the crash.
> 
> Reported-by: ticerex (OpenWrt Forum)

I would remove this since you have the link to the bug report below.
Without a real name & email, this does not make much sense.

> Fixes: 28361c403683c ("libata: add extra internal command")
> Cc: stable@kernel.org # 4.18+
> Link: https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> ticerex said when I've asked him about his real name+email for the patches:
> "Please use my forum nick."
> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
> (I know checkpatch.pl complains about that. But what can you do?)
> ---
>  drivers/ata/sata_dwc_460ex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index bec33d781ae0..061b27584667 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -137,7 +137,7 @@ struct sata_dwc_device {
>  #endif
>  };
>  
> -#define SATA_DWC_QCMD_MAX	32
> +#define SATA_DWC_QCMD_MAX	33

This is really ugly, but I do not see a better way to do it simply.
But at least, let's do something like this to avoid confusion and to show
that this driver is not doing some black magic with ATA drives:

/*
 * Allow one extra special slot for commands and DMA management to
 * account for libata internal commands.
 */
#define SATA_DWC_QCMD_MAX	(ATA_MAX_QUEUE + 1)

Thoughts ?

>  
>  struct sata_dwc_device_port {
>  	struct sata_dwc_device	*hsdev;


-- 
Damien Le Moal
Western Digital Research
