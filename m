Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D242EFA3740
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 22:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiJ0WWM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiJ0WWL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 18:22:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B23553A40
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666909330; x=1698445330;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=uhLSJ92qBvXt6tjIz80iXnOKO2hb+GtuIaZw+U1AnGs=;
  b=p/Y4UmPyvEvvCxc3XreZYN4e6C8VSNIy9GLAFqlrz7yDIpYkfEPthyo1
   XYVMCpG/lHolBBBHt2E58hGwBVd4FrFAwXWdgYoNW2se3nuVTQD42j/uJ
   NISrhTPOr7F+TugPwRQ2Nus+m2rwzh4VPLbVBwbM2LpK0MyWye/ugj9aE
   Ej8/oTeGMMfaw0Ey4/Z+/+woyEU41fEkab7VtRceSak9muaudZaGlF8kO
   Vu3Woq7jMc9ntPFSvG8mlS5KnCHe12RUuk7HcI25Rhgf52euMIlacQhOo
   aLKYFtuzHpNz8ldTkiLSxtHAMQOupVtZ1ZW53Bg/bUcnBjA4eTyKWfA1t
   A==;
X-IronPort-AV: E=Sophos;i="5.95,219,1661788800"; 
   d="scan'208";a="220082907"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 06:22:09 +0800
IronPort-SDR: kJsHBgrUi0e4zrYHesbS2DNrpEFHKEeyekgY47FvtUR1eixk4TWi3XOwCw10ICiR5emZQ8IQhB
 XcnUtm11CbV//tYs7Vlq/3YfkfA+9hrOtTqAxuF1rPpN3xjMJRaVvpYFLeYEfufTNwDbAwoHpn
 tMR4k7m7tD2B9baPfthLg72nUaavB8EbK5/WIRyNpBscCYYyW8vR9nz2sD+bhIFtFYyNPv6NRp
 J760AflT5j1D+4cPlSX676BF4N0RGvnKES4ZxNlzXkjVTQdlZNifDXA9sCHn9pnnC1nJ909nhn
 XI5RC7J5T2dzCX940z542+pc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 14:35:47 -0700
IronPort-SDR: vMG96p/plKLM4hmNLb25kdoVKp4hkTydtVDv45pvTtIyYIPmFBe0Fxu7qoIOABj8GX3Z19B7Wr
 Xv8FldUfs/FeKXRzcl3sUE7eqo9b9skdYhiJ7ytsA5NNTHnEMOSfruxpsrtgNpNDwZEvTdZIr7
 0UcSxnfQrHeh79tAbZLkqhWINvbMKOySAQeNBS5o1tcDp35SRfZFGF+s7crDjkttz3p6vxkmFn
 m+5akeLSCbTk7YOk3R4kNrZ2ncrBFBk6e7qFLL91Jt736JX7PwFo4b48W+AdQ7f7wY05qYCFPV
 qO0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 15:22:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mz0Xd20b3z1RwqL
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 15:22:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666909328; x=1669501329; bh=uhLSJ92qBvXt6tjIz80iXnOKO2hb+GtuIaZ
        w+U1AnGs=; b=ert7Kr7CTz7ZlSBIugR4esi/Pty23M07KaTE3oMN1kyKl/cJO/S
        7rVJ3CFWVYZPcUjt65o2uItqxKf6CJ/SFi9F74i+bZVxQaG3KVi5lK5bOe6S4EsO
        ee01I+iTuXT6n2jiKa/GE61jOKecI6uWc6qSnXeKy4mp+LaTJ3mTeVq9SbB51FcQ
        wAIDOhMxgfm+TnkMXpwTmIOyt7V+nzj7YWGufp+extCxYi3DOVmwz1GQXtdEq/Ks
        BARD/XZyIPAClvLmVjB05bJXb73R4pIB6QpPL1iYW2Wz3azb3ZNeya3xB1/Rwh2O
        N2wNBaykUEcZW6CUUwn8JZI7eKUpAZD/bdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DVePLQnjWV9t for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 15:22:08 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mz0Xb5L7Yz1RvLy;
        Thu, 27 Oct 2022 15:22:07 -0700 (PDT)
Message-ID: <e171ce82-fdd5-0db2-c821-849dd9467fef@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 07:22:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 4/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
 <20221027075026.240017-5-damien.lemoal@opensource.wdc.com>
 <69b5067c-dd13-a56a-3267-867902953045@suse.de>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <69b5067c-dd13-a56a-3267-867902953045@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/27/22 18:42, Hannes Reinecke wrote:
> On 10/27/22 09:50, Damien Le Moal wrote:
>> If a user issues a write command with the FUA bit set for a device with
>> NCQ support disabled (that is, the device queue depth was set to 1), the
>> LBA 48 command WRITE DMA FUA EXT must be used. However,
>> ata_build_rw_tf() ignores this and first test if LBA 28 can be used.
>> That is, for small FUA writes at low LBAs, ata_rwcmd_protocol() will
>> cause the write to fail.
>>
>> Fix this by preventing the use of LBA 28 for any FUA write request.
>> While at it, also early test if the request is a FUA read and fail these
>> requests for the NCQ-disabled case instead of relying on
>> ata_rwcmd_protocol() returning an error.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/ata/libata-core.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 81b20ffb1554..fea06f41f371 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -725,9 +725,21 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
>>   		    class == IOPRIO_CLASS_RT)
>>   			tf->hob_nsect |= ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
>>   	} else if (dev->flags & ATA_DFLAG_LBA) {
>> +		bool lba28_ok;
>> +
>> +		if (tf->flags & ATA_TFLAG_FUA) {
>> +			/* FUA reads are not defined */
>> +			if (!(tf->flags & ATA_TFLAG_WRITE))
>> +				return -EINVAL;
>> +			/* We need LBA48 / WRITE DMA FUA EXT for FUA writes */
>> +			lba28_ok = false;
>> +		} else {
>> +			lba28_ok = lba_28_ok(block, n_block);
>> +		}
>> +
>>   		tf->flags |= ATA_TFLAG_LBA;
>>   
>> -		if (lba_28_ok(block, n_block)) {
>> +		if (lba28_ok) {
>>   			/* use LBA28 */
>>   			tf->device |= (block >> 24) & 0xf;
>>   		} else if (lba_48_ok(block, n_block)) {
> 
> I am still skeptical about this change.
> Having checked the code I don't think that we ever issue a 
> REQ_READ|REQ_FUA; but at the same time there doesn't seem to be a strict 
> rule. I wonder if we shouldn't move that check into the block layer, and 
> error out any attempts to issue such?

That definitely would be good for ATA, but potentially restrictive for
scsi ? Not sure about NVMe, I have not checked the specs. That said, the
only reasonable reason to do an FUA read that I can think of would be a
"scrub" like write-and-verify feature. And I do not think that any FS
implement their scrub process using FUA.

> Otherwise we would error out an otherwise fine I/O (which we _could_ 
> have handled via PREFLUSH etc semantics), which I don't think is a good 
> idea.

Well no. Given that there is no FUA read command for the non-ncq case,
doing the same as for a write FUA in reverse order (synchronize cache
first, then read) would still not necessarily force the drive to access
the media because synchronize cache is *not* and "invalidate cache"
operation. So we cannot use the block layer either as we potentially would
end up lying about the media access part of "FUA". With that in mind,
failing the FUA read is a much safer option I think.

What we could do given that we now have FUA restricted to NCQ is this:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 77a7be74e65e..61e449877d8d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -693,7 +693,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64
block, u32 n_block,
        tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
        tf->flags |= tf_flags;

-       if (ata_ncq_enabled(dev)) {
+       if (ata_ncq_enabled(dev) || tf->flags & ATA_TFLAG_FUA) {
                /* yay, NCQ */
                if (!lba_48_ok(block, n_block))
                        return -ERANGE;

That is, ignore if NCQ is off and always use NCQ read/write for FUA.
I am not a huge fan of this as that would lead to mixing NCQ and non-NCQ
commands when the drive QD is set to 1. Not exactly nice, which is why I
did not initially modify the patch to do that.
However, with this change, we would be fully on par with scsi and can do
both read and write FUA with the same semantic, as expected from the user
if we declare that we support FUA.

This hunk:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 81b20ffb1554..fea06f41f371 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -725,9 +725,21 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64
block, u32 n_block,
                    class == IOPRIO_CLASS_RT)
                        tf->hob_nsect |= ATA_PRIO_HIGH << ATA_SHIFT_PRIO;
        } else if (dev->flags & ATA_DFLAG_LBA) {
+               bool lba28_ok;
+
+               if (tf->flags & ATA_TFLAG_FUA) {
+                       /* FUA reads are not defined */
+                       if (!(tf->flags & ATA_TFLAG_WRITE))
+                               return -EINVAL;
+                       /* We need LBA48 / WRITE DMA FUA EXT for FUA writes */
+                       lba28_ok = false;
+               } else {
+                       lba28_ok = lba_28_ok(block, n_block);
+               }
+
                tf->flags |= ATA_TFLAG_LBA;

-               if (lba_28_ok(block, n_block)) {
+               if (lba28_ok) {

Would then not really be needed.

Thoughts ?

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

