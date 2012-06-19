From: Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V2 11/16] ata: Use 32-bit DMA in AHCI for Loongson-3.
Date: Tue, 19 Jun 2012 20:36:17 +0800
Message-ID: <CAAhV-H5H6E+sshfc3p8Mq-OfVZDKA+CizZgRwAtPswkYwY=7mw@mail.gmail.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
	<1340088624-25550-12-git-send-email-chenhc@lemote.com>
	<4FE0717A.7070109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56496 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab2FSMgS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2012 08:36:18 -0400
Received: by bkcji2 with SMTP id ji2so5023235bkc.19
        for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2012 05:36:17 -0700 (PDT)
In-Reply-To: <4FE0717A.7070109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

OK, thanks.

On Tue, Jun 19, 2012 at 8:32 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 06/19/2012 02:50 AM, Huacai Chen wrote:
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index ebaf67e..3e3cfd8 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_inf=
o[] =3D
>> {
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0[board_ahci_sb700] =3D =A0 =A0/* for SB700 and SB800 =
*/
>> =A0 =A0 =A0 =A0{
>> +#ifndef CONFIG_CPU_LOONGSON3
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AHCI_HFLAGS =A0 =A0 (AHCI_HFLAG_IGN_S=
ERR_INTERNAL),
>> +#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 AHCI_HFLAGS =A0 =A0 (AHCI_HFLAG_IGN_SE=
RR_INTERNAL |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 AHCI_HFLAG_32BIT_ONLY),
>> +#endif
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D AHCI_FL=
AG_COMMON,
>
>
>
> NAK -- the place to fix this up is ahci_init_one()
>
