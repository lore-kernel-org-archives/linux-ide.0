From: Adrian Bunk <bunk@stusta.de>
Subject: [2/5] 2.6.21-rc5: known regressions
Date: Tue, 27 Mar 2007 03:59:36 +0200
Message-ID: <20070327015936.GZ16477@stusta.de>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, jgarzik@pobox.com, linux-ide@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, Mathieu =?utf-8?Q?B=C3=A9rard?= <Mathieu.Berard@crans.org>, Tejun Heo <htejun@gmail.com>, Fabio Comolli <fabio.comolli@gmail.com>, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Laurent Riffard <laurent.riffard@free.fr>, Lukas Hejtmanek <xhejtman@mail.muni.cz>
List-Id: linux-ide@vger.kernel.org

This email lists some known regressions in Linus' tree compared to 2.6.=
20.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering=
=2E


Subject    : x86_64 SMP kernel: maxcpus=3D1 crash in cpufreq
References : http://lkml.org/lkml/2007/3/26/54
Submitter  : Ingo Molnar <mingo@elte.hu>
Handled-By : Venki Pallipadi <venkatesh.pallipadi@intel.com>
Status     : problem is being debugged


Subject    : kernels fail to boot with drives on ATIIXP controller
             (ACPI/IRQ related)
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D229=
621
             http://lkml.org/lkml/2007/3/4/257
Submitter  : Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Status     : unknown


Subject    : NCQ problem with ahci and Hitachi drive  (ACPI related)
References : http://lkml.org/lkml/2007/3/4/178
             http://lkml.org/lkml/2007/3/9/475
             http://lkml.org/lkml/2007/2/22/8
Submitter  : Mathieu B=C3=A9rard <Mathieu.Berard@crans.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Patch      : http://lkml.org/lkml/2007/2/22/8
Status     : possible patch available


Subject    : libata: PATA UDMA/100 configured as UDMA/33
References : http://lkml.org/lkml/2007/2/20/294
             http://www.mail-archive.com/linux-ide@vger.kernel.org/msg0=
4115.html
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8133
             http://bugzilla.kernel.org/show_bug.cgi?id=3D8164
             http://lkml.org/lkml/2007/3/21/330
Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
             Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
             Laurent Riffard <laurent.riffard@free.fr>
             Lukas Hejtmanek <xhejtman@mail.muni.cz>
Handled-By : Tejun Heo <htejun@gmail.com>
Patch      : http://thread.gmane.org/gmane.linux.ide/17444
Status     : patch available


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
