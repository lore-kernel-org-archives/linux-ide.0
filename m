From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Sun, 26 May 2013 03:16:53 +0400
Message-ID: <51A14665.3070508@cogentembedded.com>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com> <519FF3D6.2090202@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:51100 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3EYXQ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 May 2013 19:16:56 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so5772877lbc.16
        for <linux-ide@vger.kernel.org>; Sat, 25 May 2013 16:16:55 -0700 (PDT)
In-Reply-To: <519FF3D6.2090202@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: vladimir.barinov@cogentembedded.com

Hello.

On 05/25/2013 03:12 AM, Sergei Shtylyov wrote:

>
>     Tejun, a question for you... see below.
>
>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>
>> Add Renesas R-Car on-chip 3Gbps SATA controller driver.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> [Sergei: few bugs fixed, significant cleanup]
>
>     Not all bugs turned out to be fixed... :-/
>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
>> Index: renesas/drivers/ata/sata_rcar.c
>> ===================================================================
>> --- /dev/null
>> +++ renesas/drivers/ata/sata_rcar.c
>> @@ -0,0 +1,910 @@
> [...]
>> +static void sata_rcar_bmdma_fill_sg(struct ata_queued_cmd *qc)
>> +{
>> +    struct ata_port *ap = qc->ap;
>> +    struct ata_bmdma_prd *prd = ap->bmdma_prd;
>> +    struct scatterlist *sg;
>> +    unsigned int si, pi;
>> +
>> +    pi = 0;
>> +    for_each_sg(qc->sg, sg, qc->n_elem, si) {
>> +        u32 addr, sg_len, len;
>> +
>> +        /*
>> +         * Note: h/w doesn't support 64-bit, so we unconditionally
>> +         * truncate dma_addr_t to u32.
>> +         */
>> +        addr = (u32)sg_dma_address(sg);
>> +        sg_len = sg_dma_len(sg);
>> +
>> +        /* H/w transfer count is only 29 bits long, let's be careful */
>> +        while (sg_len) {
>> +            len = sg_len;
>> +            if (len > 0x1ffffffe)
>
>    This value should have been put into the 'dma_boundary' field of the
> 'struct scsi_host_template', IIUC. Tejun, if I do it, do I need this 
> check at all?

    You haven't replied, so I went and searched an answer myself. Indeed,
it's enough to specify the right 'dma_boundary' and stop bothering about it.
Expect two patches to the driver. I think the correct branch for them 
will be
'for-3.11'.

WBR, Sergei

