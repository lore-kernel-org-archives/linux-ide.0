From: huacai chen <chenhuacai@gmail.com>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date: Mon, 18 Jun 2012 17:04:14 +0800
Message-ID: <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
	<1339747801-28691-10-git-send-email-chenhc@lemote.com>
	<4FDB08AC.8010208@mvista.com>
	<CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
	<20120617120557.GE31534@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55811 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2FRJEQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2012 05:04:16 -0400
Received: by lbbgm6 with SMTP id gm6so4122480lbb.19
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 02:04:14 -0700 (PDT)
In-Reply-To: <20120617120557.GE31534@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

Do you means it is a better idea to modify "enum board_ids" and add a
new board id such as board_ahci_sb700_loongson, and then add a new
entry in ahci_port_info[]?
If so, I think there is a problem: the pci id of our AHCI controller
is 1002:4390, if I add board_ahci_sb700_loongson, then I should also
add
{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700_loongson },
in ahci_pci_tbl[], but ahci_pci_tbl[] already has a line
{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 },
Then which entry will match the device?

On Sun, Jun 17, 2012 at 8:05 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Jun 15, 2012 at 08:42:47PM +0800, huacai chen wrote:
>> On Fri, Jun 15, 2012 at 6:04 PM, Sergei Shtylyov <sshtylyov@mvista.c=
om> wrote:
>> > Hello.
>> >
>> >
>> > On 15-06-2012 12:09, Huacai Chen wrote:
>> >
>> >> Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> >> Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> >> Signed-off-by: Hua Yan<yanh@lemote.com>
>> >
>> >
>> > =A0 You =A0should have CCed the 'linux-ide' mailing list.
>> >
>> >
>> >> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> >> index ebaf67e..3e3cfd8 100644
>> >> --- a/drivers/ata/ahci.c
>> >> +++ b/drivers/ata/ahci.c
>> >> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_=
info[] =3D
>> >> {
>> >> =A0 =A0 =A0 =A0},
>> >> =A0 =A0 =A0 =A0[board_ahci_sb700] =3D =A0 =A0/* for SB700 and SB8=
00 */
>> >> =A0 =A0 =A0 =A0{
>> >> +#ifndef CONFIG_CPU_LOONGSON3
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AHCI_HFLAGS =A0 =A0 (AHCI_HFLAG_IG=
N_SERR_INTERNAL),
>> >> +#else
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 AHCI_HFLAGS =A0 =A0 (AHCI_HFLAG_IGN=
_SERR_INTERNAL |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AHCI_HFLAG_32BIT_ONLY),
>> >> +#endif
>> >
>> >
>> > =A0 No, this #ifdef'ery won't do. You should add a new board type.
>> All Loongson-3 based machines use AMD SB700 chipsets, add a new boar=
d
>> type is better than #ifdef?
>
> SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do y=
ou
> need it when you use the same chipset?
>
> --
> Regards/Gruss,
> =A0 =A0Boris.
