From: Jody McIntyre <scjody@sun.com>
Subject: sata_mv performance; impact of NCQ
Date: Fri, 25 Apr 2008 20:16:58 -0400
Message-ID: <20080426001657.GD17369@modernduck.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:57990 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbYDZAXU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2008 20:23:20 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3Q0H0aE001487
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2008 17:17:00 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZW00301ON1OE00@fe-sfbay-10.sun.com> (original mail from scjody@sun.com)
 for linux-ide@vger.kernel.org; Fri, 25 Apr 2008 17:17:00 -0700 (PDT)
Received: from shinkansen.modernduck.com ([69.70.209.248])
 by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZW002W7OSAE3B0@fe-sfbay-10.sun.com> for
 linux-ide@vger.kernel.org; Fri, 25 Apr 2008 17:17:00 -0700 (PDT)
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have completed several performance tests of the Marvell SATA
controllers (6x MV88SX6081) in a Sun x4500 (Thumper) system.  The
complete results are available from:
http://downloads.lustre.org/people/scjody/thumper-kernel-comparison-01.ods

My ultimate goal is to replace mv_sata (the out-of-tree vendor driver)
on RHEL 4 with sata_mv on a modern kernel, and to do this I need
equivalent or better performance, especially on large (1MB) IOs.

I note the recent changes to enable NCQ result in a net performance gain
for 64K and 128K IOs, but due to a chipset limitation in the 6xxx series
(according to commit f273827e2aadcf2f74a7bdc9ad715a1b20ea7dda),
max_sectors is now limited which means we can no longer perform IOs
greater than 128K (ENOMEM is returned from an sg write.)  Therefore
large IO performance suffers - for example, the performance of 2.6.25
with NCQ support removed on 1MB IOs is better than anything possible
with stock 2.6.25 for many workloads.

Would it be worth re-enabling large IOs on this hardware when NCQ is
disabled (using the queue_depth /proc variable)?  If so I'll come up
with a patch.

Does anyone know what mv_sata does about NCQ?  I see references to NCQ
throughout the code but I don't yet understand it enough to determine
what's going on.  mv_sata _does_ support IOs greater than 128K, which
suggests that it does not use NCQ on this hardware at least.

Any advice on areas to explore to improve sata_mv's performance?  I
imagine I need to understand what mv_sata does differently, and plan on
spending some time reading that code, but I'd appreciate more specific
ideas if anyone has them.

Details on the tests I performed:

I used the sgpdd-survey tool, a low level performance test from the
Lustre iokit.  It can be downloaded from:
http://downloads.lustre.org/public/tools/lustre-iokit/ .  The tool
performs timed sgp_dd commands using various IO sizes, region counts,
and thread counts and reports aggregate bandwidth.  These results were
then graphed using a spreadsheet.

Note that the largest thread count measured is not the same on all
graphs.  For some reason, write() to the sg device returns ENOMEM to
some sgp_dd threads when large numbers of threads are run on recent
kernels.  The problem does not exist with the RHEL 4 kernel.  I have not
yet investigated why this happens.

Cheers,
Jody

-- 
Jody McIntyre - Linux Kernel Engineer, Sun HPC
