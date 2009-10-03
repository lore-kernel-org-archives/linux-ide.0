From: Bernie Innocenti <bernie@codewiz.org>
Subject: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Sat, 03 Oct 2009 01:10:42 -0400
Message-ID: <1254546642.1438.135.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.develer.com ([83.149.158.210]:59003 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZJCFRW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Oct 2009 01:17:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>

The error in the subject appears in the console immediately followed bv
a hard freeze of the machine.  The error occurs reproducibly on two
identical Opteron servers, each one equipped with two identical
controller cards:

03:04.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
03:06.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)

We can trigger the problem within a few seconds by starting a
reconstruction on a drive hooked to port 4 (counting from 0) of the
second controller.  Oddly, every other drive works reliably and the
faulty drive works if we connect it to, for example, port 4 of the first
controller.

I'd like to stress that the problem occurs systematically, on two
completely distinct machines.  We swapped drives, cables and controllers
to exclude other possibilities.

Tested with Debian kernels 2.6.26-19 and 2.6.30-8.  Let me know if
further details are needed.

-- 
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/

