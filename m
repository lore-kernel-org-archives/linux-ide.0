From: Luo Dislo <dislo_b_j@yahoo.com.tw>
Subject: Re: AHCI support Port Multiplier problem.
Date: Thu, 13 Jan 2011 16:16:00 +0800 (CST)
Message-ID: <75834.94872.qm@web74201.mail.tp2.yahoo.com>
References: <20110111143726.GE30607@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm3-vm0.bullet.mail.tp2.yahoo.com ([203.188.200.200]:47476 "HELO
	nm3-vm0.bullet.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752713Ab1AMIV7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Jan 2011 03:21:59 -0500
In-Reply-To: <20110111143726.GE30607@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Yes, refer to ahci_sb600_softreset() function solved my problem.

Thanks=20

--- 11/1/11 (=E4=BA=8C)=EF=BC=8CTejun Heo <tj@kernel.org> =E5=AF=AB=E9=81=
=93=EF=BC=9A

> =E5=AF=84=E4=BB=B6=E8=80=85: Tejun Heo <tj@kernel.org>
> =E4=B8=BB=E6=97=A8: Re: AHCI support Port Multiplier problem.
> =E6=94=B6=E4=BB=B6=E8=80=85: "Luo Dislo" <dislo_b_j@yahoo.com.tw>
> =E5=89=AF=E6=9C=AC: jgarzik@pobox.com, linux-ide@vger.kernel.org
> =E6=97=A5=E6=9C=9F: 2011=E5=B9=B41=E6=9C=8811=E6=97=A5,=E4=BA=8C,=E4=B8=
=8B=E5=8D=8810:37
> Hi,
>=20
> On Mon, Jan 10, 2011 at 09:46:45AM +0800, Luo Dislo wrote:
> > This is my company(Faraday) implemented AHCI SATA
> controller. Our=20
> > controller is not located at PCI bus, but AHB bus(ARM
> based platform).
> >=20
> > However, I modify Linux kernel builtin AHCI
> driver(ahci.c) to replace
> > the PCI related code by using platform bus. Just
> pretty similar way=20
> > with drivers/ata/ahci_platform.c (Kernel 2.6.35).
> >=20
> > I think the problem happens because libata does not
> give up, keep on=20
> > expecting the Port Multiplier Signature when we set
> CONFIG_SATA_PMP=20
> > to 1.=20
> >=20
> > I know how to fix this problem, just add
> AHCI_HFLAG_NO_PMP to
> > AHCI_HFLAGS when I connect hard drive to the
> controller. Meanwhile,
> > when I want to connect the Port Muliplier to my
> controller, I need
> > to remove AHCI_HFLAG_NO_PMP from AHCI_HFLAGS.
> >=20
> > I don't think this is a good solution because I have
> to compile two
> > version of my code. It does not make sense. We set
> CONFIG_SATA_PMP
> > to 1 and inside the driver code DOES NOT have
> AHCI_HFLAG_NO_PMP just
> > means that controller support Port Multiplier but the
> device
> > connecting to the port might be others type.
>=20
> Please take a look at ahci_sb600_softreset() in
> ahci.c.=C2=A0 The
> controller had the same problem.=C2=A0 Preferably, please
> fix your
> controller but as there are more than one controller with
> this
> problem, we probably should implement it as a quirk in
> libahci.c.
>=20
> Thanks.
>=20
> --=20
> tejun
>=20


     =20
