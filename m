From: gianluca <gianluca@sottospazio.it>
Subject: sata_sil boot problems with kernel 2.6.35 and current git
Date: Wed, 8 Sep 2010 20:26:51 +0200
Message-ID: <20100908182651.GA32114@seek.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:40740 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab0IHScr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Sep 2010 14:32:47 -0400
Received: from mail.seek.priv (87.8.255.90) by smtp206.alice.it (8.5.124.08)
        id 4C1A268C04D517AF for linux-ide@vger.kernel.org; Wed, 8 Sep 2010 20:26:52 +0200
Received: from mail.seek.priv (localhost.seek.priv [127.0.0.1])
	by mail.seek.priv (Postfix) with ESMTP id 97AA125EDB32
	for <linux-ide@vger.kernel.org>; Wed,  8 Sep 2010 20:26:51 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Today I tried  the kernel 2.6.35 in one of my boxes but I realized that the
box doesn't detect my SATA HD anymore. The logs show that the driver sata_s=
il
is correctly loaded. With 2.6.34 it worked fine.

So I tried to test the latest git to see if the issue was fixed, but that
kernel exhibits the same behaviour. Then I looked at the linux-ide mailing =
list
archives at http://marc.info/?t=3D128232284600001&r=3D1&w=3D2 and I found o=
ut that=20
the issue is known but not solved and since I could reliably reproduce the
problen I started to bisect.

The logs of the bisection are attached. It pointed to the commit
978c066691a49a205673672a55685305663a2554 (  libata: Remove excess delay in =
the
tf_load path ).

So I reverted that commit and got a bootable kernel again. I think this com=
mit
exposed a timing bug in the sata_sil driver.

gianluca

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="satasil_bisect.log"

git bisect start '--' 'drivers/ata'
# bad: [1506707a6c740db316e422239a53ae5df1727591] Linux 2.6.35.4
git bisect bad 1506707a6c740db316e422239a53ae5df1727591
# good: [e40152ee1e1c7a63f4777791863215e3faa37a86] Linus 2.6.34
git bisect good e40152ee1e1c7a63f4777791863215e3faa37a86
# bad: [c7087652e1890a3feef35b30ee1d4be68e1932cd] libata-sff: clean up BMDMA initialization
git bisect bad c7087652e1890a3feef35b30ee1d4be68e1932cd
# good: [fe6005b81e142c36f066b81ca85f80022c4ac979] pata_scc: make scc_wait_after_reset() static
git bisect good fe6005b81e142c36f066b81ca85f80022c4ac979
# bad: [978c066691a49a205673672a55685305663a2554] libata: Remove excess delay in the tf_load path
git bisect bad 978c066691a49a205673672a55685305663a2554
# good: [41dec29bcb05eb8ec396f70ce791c6e3e4ce4712] libata: introduce sff_set_devctl() method
git bisect good 41dec29bcb05eb8ec396f70ce791c6e3e4ce4712
# good: [276a47a93dbfe5d35261451925020f65cdbfcce8] pata_cmd640: don't read CFR pointlessly
git bisect good 276a47a93dbfe5d35261451925020f65cdbfcce8
# good: [95cc2c70c139936a2142bcd583da8af6f9d88efb] sata_nv: use ata_pci_sff_activate_host() instead of ata_host_activate()
git bisect good 95cc2c70c139936a2142bcd583da8af6f9d88efb

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="satasil_view.log"
Content-Transfer-Encoding: quoted-printable

commit 978c066691a49a205673672a55685305663a2554
Author: Alan Cox <alan@linux.intel.com>
Date:   Wed May 5 10:24:57 2010 +0100

    libata: Remove excess delay in the tf_load path
   =20
    We don't need to stall and wait after loading the task file and before
    issuing a command, so don't do it. This shows up on profiles and is not
    needed.
   =20
    Signed-off-by: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

--p4qYPpj5QlsIQJ0K--
