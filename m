From: Stuart_Hayes@Dell.com
Subject: losing time -- unmaskirq question
Date: Fri, 10 Oct 2003 10:36:40 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A2A@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:9746 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262817AbTJJPhD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Oct 2003 11:37:03 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I have a system that loses time when running CD-ROM stress (i.e., the system
clock runs too slowly).  This CD-ROM is in the DMA blacklist, so it is
running in PIO mode, and this system has a single, non-hyperthreading CPU.
It will lose about 20 minutes in 12 hours, if I leave it running CD-ROM
stress.

I have found that the problem is that the IDE driver leaves local interrupts
disabled for the duration of the interrupt handler, which includes the data
transfer, since the drive is in PIO mode.  I've seen this take around 10ms.
Since there is only one CPU in this system, this causes timer ticks to be
lost, since local interrupts are disabled for 10ms, and there are no other
CPUs to take the interrupt.

Turning on the unmaskirq setting with "hdparm -u1 /dev/hda" (this sets the
variable drive->unmask to a non-zero value) seems to fix the problem--this
causes the IDE driver to enable local interrupts before calling the ide-cd
specific interrupt handler (which does the actual data transfer)... which
allows the timer tick interrupt to be handled in the middle of a PIO data
transfer.

I would guess that this is a problem with *any* IDE device that's running in
PIO mode on a uniprocessor system.  I can see from the code that there are
some cases where people have found problems with unmaskirq enabled, but
these sound like bugs with particular hardware, not an architectural
problem.

Does anyone know of any reason why unmaskirq (drive->unmask) should not be
set by default?

Thanks,
Stuart
stuart_hayes@dell.com

