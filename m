From: Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>
Subject: Re: Message
Date: Mon, 29 Nov 2010 11:39:47 +0100
Message-ID: <AANLkTikyd5hN6msKhzd42Ahr=S+_xK2MODthME8pfd_W@mail.gmail.com>
References: <AANLkTinSigE4JPsFByPCkFd-+_oXQwR-V9=AsSH9Warz@mail.gmail.com>
	<1290755809.2678.14.camel@edumazet-laptop>
	<AANLkTi=8nWFHeJ0Z-WhprNqZMGprMRG5LQ+b3wKoMWWv@mail.gmail.com>
	<AANLkTi=bELgtgcWcy59KCvKwWWiuVZBb7e_hTSBHZ4cH@mail.gmail.com>
	<20101126073805.GB14282@liondog.tnic>
	<AANLkTikBgxBsGudfiN-xnN-KRNaanFrPpwOH_EMJ-oic@mail.gmail.com>
	<4CEFEEC6.20900@gmail.com>
	<AANLkTi=W2swi_5r=wMrORA5xkXq1aU5KRD-rE9f0mxxP@mail.gmail.com>
	<4CF0DC95.2050501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CF0DC95.2050501@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

2010/11/27 Tejun Heo <htejun@gmail.com>:
> So, it's a different controller. =A01b4b:91a3 instead of 1b4b:9123.
> Hmm... why did they switch vendor id from 11ab? =A0I currently don't
> have access to the datasheets but does the following blind patch work
> by any chance?
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 3288263..0c39fbb 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -380,6 +380,8 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
> =A0 =A0 =A0 =A0{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv }, =A0 =A0=
 =A0 =A0/* 6121 */
> =A0 =A0 =A0 =A0{ PCI_DEVICE(0x1b4b, 0x9123),
> =A0 =A0 =A0 =A0 =A0.driver_data =3D board_ahci_yes_fbs }, =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* 88se9128 */
> + =A0 =A0 =A0 { PCI_DEVICE(0x1b4b, 0x91a3),
> + =A0 =A0 =A0 =A0 .driver_data =3D board_ahci_yes_fbs },
>
> =A0 =A0 =A0 =A0/* Promise */
> =A0 =A0 =A0 =A0{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci }, =A0 /* P=
DC42819 */
>
> --
> tejun


Yeah it works fine. I've patched and compiled both 2.6.37-rc3 and 2.6.3=
6.1.
I can see the hdd and use them.
When this patch is applied to the kernel?
So i can use it on daily natty build instead of changing the livecd
that's quite hard for me.

Best Regards and thanks for help

Alessandro
