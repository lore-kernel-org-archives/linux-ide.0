From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date: Sun, 17 Jun 2012 14:05:57 +0200
Message-ID: <20120617120557.GE31534@liondog.tnic>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-10-git-send-email-chenhc@lemote.com>
 <4FDB08AC.8010208@mvista.com>
 <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33891 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757046Ab2FQMGC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Jun 2012 08:06:02 -0400
Content-Disposition: inline
In-Reply-To: <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: huacai chen <chenhuacai@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

On Fri, Jun 15, 2012 at 08:42:47PM +0800, huacai chen wrote:
> On Fri, Jun 15, 2012 at 6:04 PM, Sergei Shtylyov <sshtylyov@mvista.co=
m> wrote:
> > Hello.
> >
> >
> > On 15-06-2012 12:09, Huacai Chen wrote:
> >
> >> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> >> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> >> Signed-off-by: Hua Yan<yanh@lemote.com>
> >
> >
> > =C2=A0 You =C2=A0should have CCed the 'linux-ide' mailing list.
> >
> >
> >> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> >> index ebaf67e..3e3cfd8 100644
> >> --- a/drivers/ata/ahci.c
> >> +++ b/drivers/ata/ahci.c
> >> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_i=
nfo[] =3D
> >> {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0[board_ahci_sb700] =3D =C2=A0 =C2=A0/* =
for SB700 and SB800 */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >> +#ifndef CONFIG_CPU_LOONGSON3
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AHCI_HFLAGS=
 =C2=A0 =C2=A0 (AHCI_HFLAG_IGN_SERR_INTERNAL),
> >> +#else
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AHCI_HFLAGS =C2=
=A0 =C2=A0 (AHCI_HFLAG_IGN_SERR_INTERNAL |
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 AHCI_HFLAG_32BIT_ONLY),
> >> +#endif
> >
> >
> > =C2=A0 No, this #ifdef'ery won't do. You should add a new board typ=
e.
> All Loongson-3 based machines use AMD SB700 chipsets, add a new board
> type is better than #ifdef?

SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do you
need it when you use the same chipset?

--=20
Regards/Gruss,
    Boris.
