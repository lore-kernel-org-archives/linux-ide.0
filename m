From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [RFC] PATA ACPI objects support
Date: Tue, 7 Feb 2006 11:11:30 -0800
Message-ID: <20060207111130.5e52ba49.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:45492 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965003AbWBGTJg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Feb 2006 14:09:36 -0500
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k17J9Z6H005613
	for <linux-ide@vger.kernel.org>; Tue, 7 Feb 2006 19:09:35 GMT
Received: from vortex.site (vortex.co.intel.com [10.10.212.173])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k17J9ZFD001823
	for <linux-ide@vger.kernel.org>; Tue, 7 Feb 2006 19:09:35 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>

Hi,

I'm working on adding support for PATA ACPI objects as well as
SATA ACPI objects.  For PATA ACPI objects I have recently added:

ata_acpi_get_timing() - runs the _GTM ACPI method (PATA only)
ata_acpi_push_timing() - runs the _STM ACPI method (PATA only)

I'm now working on modifying the current SATA _GTF (reading)
and writing taskfile data to work on PATA also, then I will
add event-based calls to ata_acpi_get_timing(),
ata_acpi_push_timing(), etc.  This means that all of the hooks
are not yet in place, so I know that it's not all there and
working right now, but if anyone is interested, you can
download the patch(es) and apply/test.  [The
libata-rollup-2616-rc2.patch file can be used in place of the
complete quilt series.]

The pata-acpi.patch file still contains some debug-only
(temporary) code.

Patches (a quilt series + rollup) to 2.6.16-rc2 are here:
  http://www.xenotime.net/linux/SATA/2.6.16-rc2/

---
~Randy
