From: Adrian Bunk <bunk@stusta.de>
Subject: [2/6] 2.6.21-rc4: known regressions
Date: Sun, 18 Mar 2007 19:49:15 +0100
Message-ID: <20070318184915.GV752@stusta.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Vladimir Brik <no.hope@gmail.com>, Andi Kleen <ak@muc.de>, Ray Lee <ray-lk@madrabbit.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Colchao <colchaodemola@gmail.com>, Mathieu =?utf-8?Q?B=C3=A9rard?= <Mathieu.Berard@crans.org>, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Laurent Riffard <laurent.riffard@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.=
20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering=
=2E


Subject    : x86_64: boot hangs unless CONFIG_PCIEPORTBUS=3Dn and acpi=3D=
off
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8162
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Status     : unknown


Subject    : AMD Elan: Crash after "Allocating PCI resources"
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8161
Submitter  : Vladimir Brik <no.hope@gmail.com>
Handled-By : Andi Kleen <ak@muc.de>
Status     : patch available


Subject    : ACPI regression with noapic
References : http://lkml.org/lkml/2007/3/8/468
Submitter  : Ray Lee <ray-lk@madrabbit.org>
Status     : unknown


Subject    : acpi_serialize locks system during boot
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8171
Submitter  : Colchao <colchaodemola@gmail.com>
Handled-By : Len Brown <len.brown@intel.com>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=3D8171
Status     : patch available


Subject    : NCQ problem with ahci and Hitachi drive  (ACPI related)
References : http://lkml.org/lkml/2007/3/4/178
             http://lkml.org/lkml/2007/3/9/475
Submitter  : Mathieu B=C3=A9rard <Mathieu.Berard@crans.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Status     : problem is being debugged


Subject    : kernels fail to boot with drives on ATIIXP controller
             (ACPI/IRQ related)
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D229=
621
             http://lkml.org/lkml/2007/3/4/257
Submitter  : Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Status     : unknown


Subject    : libata: PATA UDMA/100 configured as UDMA/33
References : http://lkml.org/lkml/2007/2/20/294
             http://www.mail-archive.com/linux-ide@vger.kernel.org/msg0=
4115.html
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8133
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8164
Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
             Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
             Laurent Riffard <laurent.riffard@free.fr>
Handled-By : Tejun Heo <htejun@gmail.com>
             Alan Cox <alan@lxorguk.ukuu.org.uk>
Status     : Alan: Some cases should be fixed now but probably not all
                   (eg the Nvidia one)



-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
