From: Bart Hartgers <bart.hartgers@gmail.com>
Subject: [patch 0/2] sata_via: bugfixes for vt6420 and vt6421
Date: Sun, 17 Jan 2010 00:56:53 +0100
Message-ID: <20100116235653.898098245@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:31424 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab0APX6v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2010 18:58:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Dear all,

The following patches fix two bugs I encountered in the sata_via
driver.

- DMA/PIO timings for the pata slave drive on a vt6421 were not
handled correctly.  

- ATAPI DMA corruption on a vt6420. At least for some burners, the
vt6420 needs a small delay between sending the CDB and starting DMA to
prevent silent data corruption. I found this solution by experimentation
and while it works great for me, it might not work for everyone. Reports
of success or failure are appreciated.

Some more background is included in the individual patches.

Groeten,
Bart
-- 
