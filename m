From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [RFC 0/5] ACPI methods for SATA
Date: Wed, 23 Nov 2005 15:40:55 -0800
Message-ID: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:3204 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030552AbVKWXxf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2005 18:53:35 -0500
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jANNrZjK031190
	for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 23:53:35 GMT
Received: from vortex.site (vortex.co.intel.com [10.10.212.123])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id jANNrZV1025271
	for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 23:53:35 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>


This is my current work-in-progress for comments on
ACPI methods for SATA (and PATA later on, unless a patch
from Shaohua Li on the mailing list handles PATA).

Quick status:

Working:
- find devices in namespace
- evaluate _SDD
- evaluate _GTF
- simulate writing taskfile to device

TODO:
- write taskfile to device in a generic, non-controller-specific way
- add more usage events for _SDD and _GTF (SATA) per
  ACPI 3.0 spec, section 9.9.3.3, page 288.

---
~Randy
