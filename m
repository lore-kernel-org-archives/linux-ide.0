From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: sata_sil24 with port multiplier
Date: Sat, 22 Sep 2007 23:34:12 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4D911C5F@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:62418
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbXIWDdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Sep 2007 23:33:20 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

I just tried applying the patch to 2.6.22.1 with your previous patch ap=
plied and get the following:

[root@hac linux-2.6.22.1]# patch -p1 < ../fix-sata_sil24
(Stripping trailing CRs from patch.)
patching file drivers/ata/sata_sil24.c
Hunk #1 succeeded at 1145 with fuzz 2 (offset 256 lines).
Hunk #2 FAILED at 1162.
Hunk #3 succeeded at 915 (offset -3 lines).
1 out of 3 hunks FAILED -- saving rejects to file drivers/ata/sata_sil2=
4.c.rej
[root@hac linux-2.6.22.1]# vim ../sil24-irq-woc-fix.patch
[root@hac linux-2.6.22.1]# vim ../fix-sata_sil24
[root@hac linux-2.6.22.1]# make

[root@hac linux-2.6.22.1]# make modules
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/ata/sata_sil24.o
drivers/ata/sata_sil24.c: In function =E2sil24_host_intr=E2:
drivers/ata/sata_sil24.c:1178: error: stray =E2@=E2 in program
drivers/ata/sata_sil24.c:1178: error: =E2SIL=E2 undeclared (first use i=
n this function)
drivers/ata/sata_sil24.c:1178: error: (Each undeclared identifier is re=
ported only once
drivers/ata/sata_sil24.c:1178: error: for each function it appears in.)
drivers/ata/sata_sil24.c:1178: error: expected =E2)=E2 before =E2$_FLAG=
_PCIX_IRQ_WOC=E2
make[2]: *** [drivers/ata/sata_sil24.o] Error 1
make[1]: *** [drivers/ata] Error 2
make: *** [drivers] Error 2



Thanks,
Jon

-----Original Message-----
=46rom: Tejun Heo [mailto:htejun@gmail.com]=20
Sent: Saturday, September 22, 2007 8:25 PM
To: Jon Chelton
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_sil24 with port multiplier

Jon Chelton wrote:
> Thanks Tejun,
>=20
> I have applied the patch and rebuilt the module.  I do not seem to be=
=20
> getting the same error (although it only shows up during heavy disk=20
> activity).  But now I am getting a lot of spurious interrupts.

Yeah, those are harmless and expected.  The attached patch should fix t=
he problem.

--
tejun

