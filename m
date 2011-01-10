From: Luo Dislo <dislo_b_j@yahoo.com.tw>
Subject: Re: AHCI support Port Multiplier problem.
Date: Mon, 10 Jan 2011 09:46:45 +0800 (CST)
Message-ID: <55871.3142.qm@web74203.mail.tp2.yahoo.com>
References: <20110107212537.GH7355@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web74203.mail.tp2.yahoo.com ([116.214.12.95]:36199 "HELO
	web74203.mail.tp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752772Ab1AJBqs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jan 2011 20:46:48 -0500
In-Reply-To: <20110107212537.GH7355@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

This is my company(Faraday) implemented AHCI SATA controller. Our=20
controller is not located at PCI bus, but AHB bus(ARM based platform).

However, I modify Linux kernel builtin AHCI driver(ahci.c) to replace
the PCI related code by using platform bus. Just pretty similar way=20
with drivers/ata/ahci_platform.c (Kernel 2.6.35).

I think the problem happens because libata does not give up, keep on=20
expecting the Port Multiplier Signature when we set CONFIG_SATA_PMP=20
to 1.=20

I know how to fix this problem, just add AHCI_HFLAG_NO_PMP to AHCI_HFLA=
GS when I connect hard drive to the controller. Meanwhile, when I want =
to connect the Port Muliplier to my controller, I need to remove AHCI_H=
=46LAG_NO_PMP from AHCI_HFLAGS.=20

I don't think this is a good solution because I have to compile two ver=
sion of my code. It does not make sense. We set CONFIG_SATA_PMP to 1 an=
d inside the driver code DOES NOT have AHCI_HFLAG_NO_PMP just means tha=
t controller support Port Multiplier but the device connecting to the p=
ort might be others type.



Regards,

Dislo


=20

--- 11/1/8 (=E5=85=AD)=EF=BC=8CTejun Heo <tj@kernel.org> =E5=AF=AB=E9=81=
=93=EF=BC=9A

> =E5=AF=84=E4=BB=B6=E8=80=85: Tejun Heo <tj@kernel.org>
> =E4=B8=BB=E6=97=A8: Re: AHCI support Port Multiplier problem.
> =E6=94=B6=E4=BB=B6=E8=80=85: "Luo Dislo" <dislo_b_j@yahoo.com.tw>
> =E5=89=AF=E6=9C=AC: jgarzik@pobox.com, linux-ide@vger.kernel.org
> =E6=97=A5=E6=9C=9F: 2011=E5=B9=B41=E6=9C=888=E6=97=A5,=E5=85=AD,=E4=B8=
=8A=E5=8D=885:25
> Hello,
>=20
> On Fri, Jan 07, 2011 at 10:55:14AM +0800, Luo Dislo wrote:
> > I am using AHCI driver, when CONFIG_SATA_PMP is set
> and the ahci
> > driver DOES NOT have AHCI_HFLAG_NO_PMP. Libata sends
> Software Reset
> > with PMP=3D0xF, trying to detect if Port Multiplier
> connected to the
> > port. Unfortunately, if I plugged in general Hard
> drive, my
> > controller failed to identify the hard drive.
> >=20
> > What I observed was that libata always sent Software
> Reset with
> > PMP=3D0xF and I guessed expecting signature is
> 0x96690101. I think
> > libata should give up if the device does not return
> the Port
> > Multiplier signature at the first time and take the
> signature value
> > from device as the real device connnecting to the port
> now.
> >
> > What we said "support" PMP does not mean the port can
> only connnect
> > to Port Multiplier. It might connect with hard drive
> or ATAPI
> > device.
>=20
> Which controller is this?=C2=A0 Can you please post the
> output of "lspci
> -nn"?=C2=A0 SB600 had this problem and needed workaround
> but later SBs
> fixed it.=C2=A0 Looks like someone else screwed up
> similarly.
>=20
> Thanks.
>=20
> --=20
> tejun
>=20


     =20
