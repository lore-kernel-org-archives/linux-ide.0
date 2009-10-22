From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH] sata_sil: fix uninitialized variable use when
	sil_scr_read() fails
Date: Thu, 22 Oct 2009 09:17:00 +0900
Message-ID: <21eaeb5a0910211717w5692ce4em74482c7e5d4f5b9c@mail.gmail.com>
References: <20091020153456.9104e044.yuasa@linux-mips.org>
	 <4ADE9563.2030705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:59034 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZJVAQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Oct 2009 20:16:56 -0400
Received: by pxi9 with SMTP id 9so3000325pxi.4
        for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2009 17:17:01 -0700 (PDT)
In-Reply-To: <4ADE9563.2030705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, yuasa@linux-mips.org

Hi Tejun,

2009/10/21 Tejun Heo <tj@kernel.org>:
> Yoichi Yuasa wrote:
>> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
>>
>> ---
>> =A0drivers/ata/sata_sil.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
>> index 3cb69d5..d7fff6b 100644
>> --- a/drivers/ata/sata_sil.c
>> +++ b/drivers/ata/sata_sil.c
>> @@ -439,7 +439,7 @@ static void sil_host_intr(struct ata_port *ap, u=
32 bmdma2)
>> =A0 =A0 =A0 u8 status;
>>
>> =A0 =A0 =A0 if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 u32 serror;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 serror =3D 0;
>
> The first usage of that is
>
> =A0sil_scr_read(&ap->link, SCR_ERROR, &serror);
>
> which sets the value. =A0So, I don't think the patch is necessary. =A0=
If
> it triggers a compile warning, putting uninitialized_var() macro will
> be more appropriate.

If sil_scr_read() is error, 'serror' is not initialized.
After that, the wrong bits add to 'ap->link.eh_info.serror' when
'serror & SERR_PHYRDT_CHG' is true.

Yoichi
