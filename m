From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Date: Tue, 01 Aug 2006 01:00:08 +0900
Message-ID: <44CE2908.8080502@gmail.com>
References: <20060728134550.030a0eb8@werewolf.auna.net>	<44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38646 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751152AbWGaQAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Jul 2006 12:00:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so839485ugc
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2006 08:59:59 -0700 (PDT)
In-Reply-To: <20060731172452.76a1b6bd@werewolf.auna.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?IkouQS4gTWFnYWxsw7NuIg==?= <jamagallon@ono.com>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>

J.A. Magall=C3=B3n wrote:
> werewolf:~> lspci
> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE =
Controller (rev 02)
> 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controll=
er (rev 02)
> werewolf:~> lspci -n
> 00:1f.1 0101: 8086:24db (rev 02)
> 00:1f.2 0101: 8086:24d1 (rev 02)

You compiled w/ ATA_ENABLE_PATA, right?

>> Also, can you report what the kernel says with the=20
>> attached patch applied?
>>
>=20
> I reworked it to look like this:
>=20
>     if (legacy_mode) {
>         probe_ent =3D ata_pci_init_legacy_port(pdev, port, legacy_mod=
e);
>         dev_printk(KERN_INFO, &pdev->dev,
>            "XXX: legacy_mode probe_ent=3D%p\n", probe_ent);

This is where the problem is.  Ah.. I see.  Alan's=20
rework-legacy-handling patch got into mm.

=3D=3D=3D=3D=3D
rework-legacy-handling-to-remove-much-of-the-cruft.patch

=46rom: Alan Cox <alan@lxorguk.ukuu.org.uk>

Kill host_set->next
=46ix simplex support
Allow per platform setting of IDE legacy bases
Turn per device tuning on so that PATA timings are fully enabled

Some of this can be tidied further later on, in particular all the
legacy port gunge belongs as a PCI quirk/PCI header decode to understan=
d
the special legacy IDE rules in the PCI spec.

Longer term Jeff also wants to move the request_irq/free_irq out of cor=
e
which will make this even cleaner.
=3D=3D=3D=3D=3D

These are patches #110-112.  Andrew, can you drop those patches for the=
=20
time being?  I'm working on integrating those into libata #upstream now=
=2E=20
  Also, please drop #113 libata_resume_fix.patch.  This shouldn't be=20
necessary anymore.

Thanks.

--=20
tejun
