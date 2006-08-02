From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
Subject: Re: [2.6.18-rc2-mm1] pata_via fails
Date: Wed, 2 Aug 2006 23:43:44 +0200
Message-ID: <20060802234344.6c2bf2b9@werewolf.auna.net>
References: <20060802010415.2bebc5fc@werewolf.auna.net>
	<1154474307.3819.5.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:59113 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932240AbWHBVnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2006 17:43:53 -0400
In-Reply-To: <1154474307.3819.5.camel@localhost.portugal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sergio@sergiomb.no-ip.org
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, 02 Aug 2006 00:18:27 +0100, Sergio Monteiro Basto <sergio@sergi=
omb.no-ip.org> wrote:

> On Wed, 2006-08-02 at 01:04 +0200, J.A. Magall=C3=B3n wrote:
> > Jul 10 15:09:46 nada kernel: PCI: VIA IRQ fixup for 0000:00:11.1, f=
rom
> > 255 to 0
> > Any ideas ?
> yes, try this patch
> http://lkml.org/lkml/2006/7/28/99
> As you are using -mm tree use just hunk #1 above
>=20
> --- linux-2.6.17.i686/drivers/pci/quirks.c.orig	2006-07-28 12:59:04.0=
00000000 +0100
> +++ linux-2.6.17.i686/drivers/pci/quirks.c	2006-07-28 13:26:49.000000=
000 +0100
> @@ -648,11 +648,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
>   *
>   * Some of the on-chip devices are actually '586 devices' so they ar=
e
>   * listed here.
> + *=20
> + * if flags say that we have working apic(s), we don't need to quirk=
 these
> + * devices
>   */
>  static void quirk_via_irq(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
> =20
> +	if ((smp_found_config && !skip_ioapic_setup && nr_ioapics) || cpu_h=
as_apic)
> +		return;
> +
>  	new_irq =3D dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq !=3D irq) {
>=20

Sorry, it did not help :(.


--
J.A. Magallon <jamagallon()ono!com>     \               Software is lik=
e sex:
                                         \         It's better when it'=
s free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam05 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #2 SM=
P PREEMPT
