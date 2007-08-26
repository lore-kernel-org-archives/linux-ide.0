From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pdc202xx_new: fix PCI refcounting
Date: Sun, 26 Aug 2007 16:56:49 +0400
Message-ID: <46D17891.4010007@ru.mvista.com>
References: <200708182246.48109.sshtylyov@ru.mvista.com> <200708212201.36591.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:54030 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbXHZMyN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 08:54:13 -0400
In-Reply-To: <200708212201.36591.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>The driver erroneously "lets go" the mate IDE chip in init_setup_pdc2=
0270()
>>when ide_setup_pci_devices() call succeeds -- fix this, and drop a co=
uple of
>>useless assignments in this function while at it...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied but

>>---
>>This patch is against the current Linus' tree, it has only been compi=
le tested
>>since I do not have PDC2027x chips (and even less so behind DC21150 b=
ridge :-).

>>Index: linux-2.6/drivers/ide/pci/pdc202xx_new.c
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>--- linux-2.6.orig/drivers/ide/pci/pdc202xx_new.c
>>+++ linux-2.6/drivers/ide/pci/pdc202xx_new.c
[...]
>>@@ -521,7 +521,7 @@ static int __devinit init_setup_pdcnew(s
>> static int __devinit init_setup_pdc20270(struct pci_dev *dev,
>> 					 ide_pci_device_t *d)
>> {
>>-	struct pci_dev *findev =3D NULL;
>>+	struct pci_dev *findev;

> drivers/ide/pci/pdc202xx_new.c: In function =E2=80=98init_setup_pdc20=
270=E2=80=99:
> drivers/ide/pci/pdc202xx_new.c:530: warning: =E2=80=98findev=E2=80=99=
 may be used uninitialized in this function

> with gcc version 4.1.2 20070626 (Red Hat 4.1.2-13)

> Seems to be gcc problem

    No, it must be all those pills I'm taking... ;-)

> but I reverted this chunk.

    And you were absolutely right -- findev must be NULL for the search=
 to go=20
thru all the PCI devices. :-/

> Update: after applying patch #2/2 and fixing the reject caused by the=
 above change
> warning disappears (patch #2/2 besides renaming "findev" to "dev2" mo=
ves the code
> around making it easier for gcc to deduce what is going on :).

    Right, because pci_get_slot() is not a "device scanner" and so does=
n't=20
need the starting node.
    I guess there's no need to recast now?

WBR, Sergei
