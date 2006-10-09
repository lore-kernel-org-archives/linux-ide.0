From: Elias Oltmanns <oltmanns-OhoefBWHl6Eb1SvskN2V4Q@public.gmane.org>
Subject: Debugging strange system lockups possibly triggered
	by ATA commands
Date: Mon, 09 Oct 2006 13:32:37 +0200
Message-ID: <877iz9ohbe.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hdaps-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=hdaps-devel>
List-Post: <mailto:hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/hdaps-devel>,
	<mailto:hdaps-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: hdaps-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: hdaps-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdaps-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi there,

recently, I've adapted the hdaps_protect patch to make it work with
kernel 2.6.18. This patch adds a file "protect" to the queue directory
of block devices managed by ide or libata in sysfs. Depending on the
drive's capabilities or a module/kernel parameter, an IDLE IMMEDIATE
with UNLOAD feature or a STANDBY IMMEDIATE command is issued when ever
a positive value is written to this "protect" file. After completion
of this command, the request queue of the respective device is stopped
in order to prevent it from performing further IO operations. The
queue is started again after a certain timeout has elapsed, that is,
as many seconds as the positive number that has originally been
written to the "protect" file.

The purpose of this patch is to provide an interface to unload the
disk heads on request from user space, e.g., in order to minimise the
chance for the heads to hit the platter in certain situations like
a laptop sliding off the lap. This makes it imperative to insert the
unload command at the head of the request queue.

Testing the patch, I experienced some nasty system lockups which I
cannot quite reliably reproduce, let alone having an idea as to what
might be the cause. Since these lockups occurred on my machine
regardless whether I used the ide piix driver in vanilla 2.6.18 or the
ata_piix driver with pata support enabled in Jeff Garzik's git tree
(upstream-linus as of 2006-09-29), and since the ide related part of
the patch had to be changed very little from 2.6.17 to 2.6.18, there
seem to be two options: Either I've missed an important change in the
way io requests and the request queue have to be handled in 2.6.18, or
the patch just demonstrates a flaw somewhere else in the kernel. The
former seems quite likely considering that I'm rather superficially
acquainted with the relevant api. The latter does not seem completely
unlikely, at least, as the problem occurs on ide as well as libata.

Unfortunately, my system just froze without displaying a panic
message. Moreover, the lockup appears to be hard to reproduce. Here
are some details about some of the tests I've performed so far:


1. vanilla 2.6.18:
------------------
I used my standard configuration for self compiled kernels and make
oldconfig to adjust it to 2.6.18. Basically, that means a highly
modularised kernel with ramdisk and initrd support compiled in - by
that time I hadn't realised yet that ramdisk support isn't needed for
initramfs support anymore. Amongst the modules: ide-core, ide-disk,
ide-generic, piix, no sata support. With the hdaps_protect patch applied, I
could reliably reproduce the system freeze by the following steps:
Boot into single user mode
# modprobe ibm-acpi
# while true; do echo -n 1 > /sys/block/hda/queue/protect; \
> echo -n 0 > /sys/block/hda/queue/protect; done
The system freezes and there is no way to reactivate it, except a cold
reset. Note that there was no freeze without ibm-acpi being loaded,
even modprobe ibm-acpi; modprobe -r ibm-acpi and the while loop did
not lead to a freeze. However, switching to the external monitor and
back again after loading ibm-acpi prevents the system from freezing
too which makes the whole thing even more difficult.


2. Branch upstream-linus from Jeff Garzik's git tree as of 2006-09-29:
----------------------------------------------------------------------
Here I used almost the identical configuration except that I disabled
ide support completely and enabled sata support and the module
ata_piix. Besides, #define ATA_ENABLE_PATA was set in
include/linux/libata.h.
With this setup the system shew the same behavior as described above.


3. Vanilla 2.6.18 with stripped configuration:
----------------------------------------------
In the hope to provide a minimal test case, I stripped the
configuration considerably, disabling several subsystems lke scsi, a
lot of networking stuff, and so on. Additionally, I disabled
ide-generic and ramdisk support, as I'm using initramfs anyway. The
module ibm_acpi was still included.
Regrettably, the freeze was not reproducible anymore.

4. Branch upstream-linus from Jeff Garzik's git tree as of 2006-10-09:
----------------------------------------------------------------------
Exact same config as in 2. Problem is not reproducible as in 3. and
I'm currently working on this system.


Admittedly, I'm completely lost at this point. That's why I'm asking
you for advice and suggestions how to debug this problem. If you want
to have a look at the patch in question, please see:
1. applying to vanilla 2.6.18
   <http://www.uni-bonn.de/~oltmanns/linux/hdaps_protect-2.6.18-20060922-3.patch>
2. applying to Jeff's git tree as in examples 2. and 4. above:
   <http://www.uni-bonn.de/~oltmanns/linux/hdaps_protect-2.6.18-20060922-pata-2.patch>

A slightly stripped version of the patch is available too, which has
been verified to trigger the described problem in exactly the same way
as the original but lacks the IDLE IMMEDIATE feature (leaving the
STANDBY IMMEDIATE option only) in order to make it (hopefully) more
readable and easier to understand. You can find this version of the
patch which applies to vanilla 2.6.18 here:
<http://www.uni-bonn.de/~oltmanns/linux/hdaps_protect-stripped-2.6.18-1.patch>

Kind regards and thanks for your help in advance,

Elias

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
