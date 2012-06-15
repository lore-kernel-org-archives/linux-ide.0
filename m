From: huacai chen <chenhuacai@gmail.com>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date: Fri, 15 Jun 2012 20:42:47 +0800
Message-ID: <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
	<1339747801-28691-10-git-send-email-chenhc@lemote.com>
	<4FDB08AC.8010208@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41243 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771Ab2FOMms convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2012 08:42:48 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so2814848lbb.19
        for <linux-ide@vger.kernel.org>; Fri, 15 Jun 2012 05:42:47 -0700 (PDT)
In-Reply-To: <4FDB08AC.8010208@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

On Fri, Jun 15, 2012 at 6:04 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
>
> On 15-06-2012 12:09, Huacai Chen wrote:
>
>> Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> Signed-off-by: Hua Yan<yanh@lemote.com>
>
>
> =A0 You =A0should have CCed the 'linux-ide' mailing list.
>
>
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
>
>
> =A0 No, this #ifdef'ery won't do. You should add a new board type.
All Loongson-3 based machines use AMD SB700 chipsets, add a new board
type is better than #ifdef?

>
> MBR, Sergei
