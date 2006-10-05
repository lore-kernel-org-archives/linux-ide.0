From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] x86, fix rwsem build bug on CONFIG_M386=y
Date: Thu, 5 Oct 2006 10:27:58 +0200
Message-ID: <20061005082757.GA27120@elte.hu>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005042816.GD16812@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061005042816.GD16812@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Klaus Knopper <knopper@knopper.net>, Andi Kleen <ak@suse.de>, Luca Tettamanti <kronos.it@gmail.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, len.brown@intel.com, linux-acpi@vger.kernel.org, Olaf Hering <olaf@aepfle.de>, Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> This email lists some known regressions in 2.6.19-rc1 compared to 
> 2.6.18.

thanks Adrian - this list is extremely useful in my opinion! Please keep 
up the good work.

> Subject    : CONFIG_M386=y rwsem compile error
> References : http://lkml.org/lkml/2006/10/3/240
> Submitter  : Klaus Knopper <knopper@knopper.net>
> Guilty     : Andi Kleen <ak@suse.de>
>              commit add659bf8aa92f8b3f01a8c0220557c959507fb1
> Status     : unknown

find the fix below.

-------------------->
Subject: [patch] x86, fix rwsem build bug on CONFIG_M386=y
From: Ingo Molnar <mingo@elte.hu>

CONFIG_M386 turns on spinlock-based generic rwsems - which surprises the 
semaphore.S rwsem stubs. Tested both with and without CONFIG_M386.

Reported-by: Klaus Knopper <knopper@knopper.net>
Triaged-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/lib/semaphore.S |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/arch/i386/lib/semaphore.S
===================================================================
--- linux.orig/arch/i386/lib/semaphore.S
+++ linux/arch/i386/lib/semaphore.S
@@ -152,6 +152,8 @@ ENTRY(__read_lock_failed)
 
 #endif
 
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
+
 /* Fix up special calling conventions */
 ENTRY(call_rwsem_down_read_failed)
 	CFI_STARTPROC
@@ -214,3 +216,4 @@ ENTRY(call_rwsem_downgrade_wake)
 	CFI_ENDPROC
 	END(call_rwsem_downgrade_wake)
 
+#endif
