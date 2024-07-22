Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96A6FDC
	for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610828; cv=none; b=qeJURwS74FZzUnlbnLm/2IYYhu9gtpEAFMx/o/UVCDZmJGIZA+rDMS+uBoL9/I5PtpxBTe4aggSirkjqhZwlqw/ocWWdNzE3X3n9jYwcuANq68FD9aQ3tnLIhtwluki75Vpz+9+9DBvqcRdtn/SNDEBDSly0nSMNYU8r2SfO+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610828; c=relaxed/simple;
	bh=Jfa4nk8efjD0W6VGCi99RacMaCA0gahIQmOX1UM7fHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=db17huNBRL1rUvXxIXwkkV0wJK4EP315AIVJuRO/ApsiK7vq+RWCnQpusJaTBbxa7jjjZkXGs+atk95gK08/6bdlN3eqnsH25AztVn//lQQ8Gzcm2WMrWmBZDIoXEBdYJ8M1Mmswt8xEyeJdb+6MUXUm6YboI/ndrnG9v0rgVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adh8S4TV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adh8S4TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D74C4AF0B;
	Mon, 22 Jul 2024 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721610827;
	bh=Jfa4nk8efjD0W6VGCi99RacMaCA0gahIQmOX1UM7fHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=adh8S4TVlFjCSnP60kwV5HzKkkj6wdh3XuBoeL5GQDPY8CnTbsSsQXTgjx4qayaiT
	 uIUadX3QbeIv4aZ7EaGYBVV6LeONMbSBlOq0fCHFCpZkWQmNhrkEf3S16/eps7DIi2
	 Jyg0rdCAepAgKrnoI+gounG5/E2B1WK771/9/g4NksUf1BlxcSD4pS+StfcOcIO8rj
	 QSdGKxUaf0jCBug1DWnI87h+oVkFAcgnJUnlzGpyewQxaMxHA6DEu4KoGQMm8kFlv4
	 1EYPqM4kwNVhmacD3ojEfQWA0B+CNyXxGT5VxbWMd35O1e7INExj/hvaDYD06nTLLN
	 w9XyHlfQoe2+A==
Message-ID: <03ec2407-7c6e-4f67-81dd-83646ad77395@kernel.org>
Date: Mon, 22 Jul 2024 10:13:46 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ata: libata: Print horkages applied to devices
To: Igor Pylypiv <ipylypiv@google.com>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20240718103358.176260-1-dlemoal@kernel.org>
 <20240718103358.176260-4-dlemoal@kernel.org> <ZpribtkCeraCs3SN@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZpribtkCeraCs3SN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/24 07:02, Igor Pylypiv wrote:
> On Thu, Jul 18, 2024 at 07:33:58PM +0900, Damien Le Moal wrote:
> 
> Hi Damien,
> 
>> Introduce the function ata_dev_print_horkage() to print the horkage
>> flags that will be used for a device. This new function is called from
>> ata_dev_horkage() when a match on a device model or device model and
>> revision is found for a device in the ata_dev_horkages array.
>>
>> To implement this function, the ATA_HORKAGE_ flags are redefined using
>> the new enum ata_horkage which defines the bit shift for each horkage
>> flag. The array of strings ata_horkage_names is used to define the name
>> of each flag, which are printed by ata_dev_print_horkage().
>>
>> Example output for a device listed in the ata_dev_horkages array and
>> which has the ATA_HORKAGE_DISABLE flag applied:
>>
>> [10193.461270] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> [10193.469190] ata1.00: Model ASMT109x- Config, applying horkages: disable
>> [10193.469195] ata1.00: unsupported device, disabling
>> [10193.481564] ata1.00: disable device
>>
>> And while at it, make sure to use the unsigned int type for horkage
>> flags as struct ata_device->horkage is an unsugned int.
> 
> 
> It looks like we're soon going to run out of bits to use for the horkage
> flags. I think it might be better to change ata_device->horkage type to
> unsigned long. Given that the horkage bit numbers will be implicitly
> handled by the ata_horkage enum, it is more likely for someone to add
> a new horkage types/flags that will exceed 32 bits.

Yes, we are using 29 bits out of 32 available with unsigned int. But unsigned
long is still 32-bits on 32-bits arch, so that would not be an appropriate
solution. Furthermore, if one defines a horkage bit past value 31, you get a
compilation warning:

In file included from drivers/pnp/resource.c:20:
./include/linux/libata.h:439:30: warning: left shift count >= width of type
[-Wshift-count-overflow]
  439 |         ATA_HORKAGE_32 = (1U << __ATA_HORKAGE_32),
      |                              ^~

which would be enough to signal to something needs to be done about the lack of
bits. So we can deal with that when/if it becomes needed.

We can also trivially add build checks to generate a compilation error:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9cf0fe84186f..ef81aa0c1520 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4335,6 +4335,9 @@ static unsigned int ata_dev_horkage(const struct
ata_device *dev)
        unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
        const struct ata_dev_horkage_entry *ad = ata_dev_horkages;

+       /* dev->horkage is an unsigned int. */
+       BUILD_BUG_ON(__ATA_HORKAGE_MAX > 31);
+
        ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
        ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5378d364c0f2..f9e922fb6446 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -58,6 +58,8 @@
 /*
  * Horkage types. May be set by libata or controller on drives.
  * Some horkage may be drive/controller pair dependent.
+ * ata_device->horkage is an unsigned int, so __ATA_HORKAGE_MAX must not
+ * exceed 31.
  */
 enum ata_horkage {
        __ATA_HORKAGE_DIAGNOSTIC,       /* Failed boot diag */
@@ -91,6 +93,8 @@ enum ata_horkage {
        __ATA_HORKAGE_NO_ID_DEV_LOG,    /* Identify device log missing */
        __ATA_HORKAGE_NO_LOG_DIR,       /* Do not read log directory */
        __ATA_HORKAGE_NO_FUA,           /* Do not use FUA */
+
+       __ATA_HORKAGE_MAX,
 };

 enum {

So I think I will respin the series and add this.

-- 
Damien Le Moal
Western Digital Research

