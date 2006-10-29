From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 00:13:58 +0100
Message-ID: <20061029231358.GI27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr, oprofile-list@lists.sf.net, Martin Lorenz <martin@lorenz.eu.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>, Jens Axboe <jens.axboe@oracle.com>, Komuro <komurojun-mbn@nifty.com>, Thomas Gleixner <tglx@linutronix.de>, Christian <christiand59@web.de>, Mark Langsdorf <mark.langsdorf@amd.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk
List-Id: linux-ide@vger.kernel.org

This email lists some known regressions in 2.6.19-rc3 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : PCI: MMCONFIG breakage
References : http://lkml.org/lkml/2006/10/23/182
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Status     : unknown, both BIOS and Direct work


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : X60s: BUG()s, lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : T60 stops triggering any ACPI events
References : http://lkml.org/lkml/2006/10/4/425
             http://lkml.org/lkml/2006/10/16/262
             http://bugzilla.kernel.org/show_bug.cgi?id=7408
Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : Thomas will investigate


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Handled-By : Mark Langsdorf <mark.langsdorf@amd.com>
Status     : Mark is investigating


