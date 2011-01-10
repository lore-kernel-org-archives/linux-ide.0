From: Mac Lin <mkl0301@gmail.com>
Subject: Re: AHCI support Port Multiplier problem.
Date: Mon, 10 Jan 2011 15:42:24 +0000 (UTC)
Message-ID: <loom.20110110T161018-804@post.gmane.org>
References: <20110107212537.GH7355@mtj.dyndns.org> <55871.3142.qm@web74203.mail.tp2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40632 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab1AJPuO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jan 2011 10:50:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1PcK0S-0002U4-1y
	for linux-ide@vger.kernel.org; Mon, 10 Jan 2011 16:50:05 +0100
Received: from 122-120-32-69.dynamic.hinet.net ([122.120.32.69])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 16:50:04 +0100
Received: from mkl0301 by 122-120-32-69.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Jan 2011 16:50:04 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Luo Dislo <dislo_b_j <at> yahoo.com.tw> writes:

>=20
> Hello,
>=20
> This is my company(Faraday) implemented AHCI SATA controller. Our=20
> controller is not located at PCI bus, but AHB bus(ARM based platform)=
=2E
>=20
> However, I modify Linux kernel builtin AHCI driver(ahci.c) to replace
> the PCI related code by using platform bus. Just pretty similar way=20
> with drivers/ata/ahci_platform.c (Kernel 2.6.35).
>=20
> I think the problem happens because libata does not give up, keep on=20
> expecting the Port Multiplier Signature when we set CONFIG_SATA_PMP=20
> to 1.=20
>=20
> I know how to fix this problem, just add AHCI_HFLAG_NO_PMP to AHCI_HF=
LAGS when
I connect hard drive to the
> controller. Meanwhile, when I want to connect the Port Muliplier to m=
y
controller, I need to remove
> AHCI_HFLAG_NO_PMP from AHCI_HFLAGS.=20
>=20
> I don't think this is a good solution because I have to compile two v=
ersion of
my code. It does not make sense.
> We set CONFIG_SATA_PMP to 1 and inside the driver code DOES NOT have
AHCI_HFLAG_NO_PMP just means that
> controller support Port Multiplier but the device connecting to the p=
ort might
be others type.

We have a similar issue on cns3xxx
http://www.spinics.net/lists/linux-ide/msg39512.html
http://www.spinics.net/lists/linux-ide/msg39859.html

Could you try the following patch with CONFIG_SATA_PMP enabled and see =
if it fix
the issue?
If so, then it would be the same issue.
---
 drivers/ata/libahci.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ebc08d6..081548f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1302,10 +1302,15 @@ static int ahci_softreset(struct ata_link *link=
,
unsigned int *class,
                          unsigned long deadline)
 {
        int pmp =3D sata_srst_pmp(link);
+       int ret;

        DPRINTK("ENTER\n");

-       return ahci_do_softreset(link, class, pmp, deadline, ahci_check=
_ready);
+       ret =3D ahci_do_softreset(link, class, pmp, deadline, ahci_chec=
k_ready);
+       if (ret && pmp)
+               return ahci_do_softreset(link, class, 0, deadline,
+                       ahci_check_ready);
+       return ret;
 }
 EXPORT_SYMBOL_GPL(ahci_do_softreset);

--=20

>=20
> Regards,
>=20
> Dislo
>=20
> --- 11/1/8 (=E5=85=AD)=EF=BC=8CTejun Heo <tj <at> kernel.org> =E5=AF=AB=
=E9=81=93=EF=BC=9A
>=20
> > =E5=AF=84=E4=BB=B6=E8=80=85: Tejun Heo <tj <at> kernel.org>
> > =E4=B8=BB=E6=97=A8: Re: AHCI support Port Multiplier problem.
> > =E6=94=B6=E4=BB=B6=E8=80=85: "Luo Dislo" <dislo_b_j <at> yahoo.com.=
tw>
> > =E5=89=AF=E6=9C=AC: jgarzik <at> pobox.com, linux-ide <at> vger.ker=
nel.org
> > =E6=97=A5=E6=9C=9F: 2011=E5=B9=B41=E6=9C=888=E6=97=A5,=E5=85=AD,=E4=
=B8=8A=E5=8D=885:25
> > Hello,
> >=20
> > On Fri, Jan 07, 2011 at 10:55:14AM +0800, Luo Dislo wrote:
> > > I am using AHCI driver, when CONFIG_SATA_PMP is set
> > and the ahci
> > > driver DOES NOT have AHCI_HFLAG_NO_PMP. Libata sends
> > Software Reset
> > > with PMP=3D0xF, trying to detect if Port Multiplier
> > connected to the
> > > port. Unfortunately, if I plugged in general Hard
> > drive, my
> > > controller failed to identify the hard drive.
> > >=20
> > > What I observed was that libata always sent Software
> > Reset with
> > > PMP=3D0xF and I guessed expecting signature is
> > 0x96690101. I think
> > > libata should give up if the device does not return
> > the Port
> > > Multiplier signature at the first time and take the
> > signature value
> > > from device as the real device connnecting to the port
> > now.
> > >
> > > What we said "support" PMP does not mean the port can
> > only connnect
> > > to Port Multiplier. It might connect with hard drive
> > or ATAPI
> > > device.
> >=20
> > Which controller is this?=C2=A0 Can you please post the
> > output of "lspci
> > -nn"?=C2=A0 SB600 had this problem and needed workaround
> > but later SBs
> > fixed it.=C2=A0 Looks like someone else screwed up
> > similarly.
> >=20
> > Thanks.
> >=20
> > --=20
> > tejun


Best Regards,
Mac Lin


