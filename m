Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C34B1E76
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608439; cv=none; b=V1a5Giha2zf3JMFB4wShwoUbe7MO/xPBVegHQs4efD0EGX/go3NNYhrEUd2IeQdZ8J2d3ZiZH5WE7No4B5ArLTli+4NWMGAJdJgemxrffLK/Y3z6ZF/gVScxR+ws2jmOdMtqdb0diT+yrQaY0zMqHZGgtRsTyISyF8mQ/C8ONRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608439; c=relaxed/simple;
	bh=1S4qQBdmvSWeHY25IW086QUCgKfVzRijQ9aY4+LKyxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhuyQqA2t78pAAe9RlDkX3BZSqC8F9YKXzwHO4XrCYlMItmPapAXPsYB9Kqno3ROzLNwRYosH4oYyQoDpr0d2VW+PCAtEDDmyKgtggoTjQ5ns8KGryecAHHfgMZcwA3FHQy85Gfgr3KzpCfpclLXdWo+R5ex4q0O9Pygi+LI6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZnK2vsc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZnK2vsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEDC4CEE7;
	Wed,  7 May 2025 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746608438;
	bh=1S4qQBdmvSWeHY25IW086QUCgKfVzRijQ9aY4+LKyxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jZnK2vscBY07qOJy0fbRqSJvLFBLlfSxOGtzpMY9m8RerFWx0Q4RyJiUVmRjb226B
	 U46B2Y7jLvYHnnzeo7fQOoD1pjE85c3gRaCgOtEqjPUzZCHYZ5YAaUxYSbvJlTcOO8
	 gO9ooXghw2XEn5BldH6zgCJmqLxQSv/lRxg0S/kAn3VQagXEMu11XgsIgk5Y1pI2uo
	 8FXclX+69aoL+TdAdDhjF95AWEabqfcrS8lyp0YmiWMeK4yNhUK1DmPt4V2/V+ykHZ
	 okIxa5JlM31sC6jnUr+4AFPHoKl7iLvhBuYY5IiOv0p0ULa28b57XQ7KyCX3RjHS3l
	 5tRC9lNJPLU+A==
Message-ID: <e1450eab-e8f0-4519-9e9f-9bf52a51c2ee@kernel.org>
Date: Wed, 7 May 2025 17:59:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <Niklas.Cassel@wdc.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
 <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen>
 <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 2:09 AM, Mikko Juhani Korhonen wrote:
> ma 5.5.2025 klo 18.37 Niklas Cassel (cassel@kernel.org) kirjoitti:
> 
>> On Mon, May 05, 2025 at 10:58:22AM +0300, Mikko Juhani Korhonen wrote:
>>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
>>>>>> It would be better to have more details on this since only the 2TB
>>>>>> model is targeted.
>>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
>>> from 6.9.0 on as they just keep resetting the SATA link , but they
>>> have worked flawlessly with 6.8.x for a year and also now with the
>>> quirk applied.
>>> I have also tested a different WDC model with med_power_with_dipm on
>>> the same SATA port and there are no problems.
>>> But after you guys got suspicious I found there is in fact a SATA port
>>> on my motherboard where the WD20EFAX-68FB5N0 works with LPM on
>> This motherboard looks to be AMD chipset, so I assume AMD AHCI controller.
>>
>> Could you send the output of:
>> $ lspci -nn | grep -E "SATA|AHCI"
> 
> mjkorhon@taavi:~$ sudo lspci -nn | grep -E "SATA|AHCI"
> 01:00.1 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] 500
> Series Chipset SATA Controller [1022:43eb]

Mikko,

could you also please try this patch on top of a vanilla 6.15 kernel (no quirk
patch applied) ?

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 163ac909bd06..a09b7b825780 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -52,6 +52,7 @@ enum board_ids {
        board_ahci_ign_iferr,
        board_ahci_no_debounce_delay,
        board_ahci_no_msi,
+       board_ahci_no_dipm,
        /*
         * board_ahci_pcs_quirk is for legacy Intel platforms.
         * Modern Intel platforms should use board_ahci instead.
@@ -152,6 +153,12 @@ static const struct ata_port_info ahci_port_info[] = {
                .udma_mask      = ATA_UDMA6,
                .port_ops       = &ahci_ops,
        },
+       [board_ahci_no_dipm] = {
+               .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
+               .pio_mask       = ATA_PIO4,
+               .udma_mask      = ATA_UDMA6,
+               .port_ops       = &ahci_ops,
+       },
        [board_ahci_no_msi] = {
                AHCI_HFLAGS     (AHCI_HFLAG_NO_MSI),
                .flags          = AHCI_FLAG_COMMON,
@@ -466,6 +473,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
        { PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD
Hudson-2 (AHCI mode) */
        { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
        { PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
+       { PCI_VDEVICE(AMD, 0x43EB), board_ahci_no_dipm }, /* 500 Series Chipset */
        /* AMD is using RAID class only for ahci controllers */
        { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
          PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },


-- 
Damien Le Moal
Western Digital Research
