From: Tejun Heo <tj@kernel.org>
Subject: ahci: CAP_SSS and parallel scan
Date: Thu, 06 May 2010 10:22:33 +0200
Message-ID: <4BE27C49.5090809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33112 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098Ab0EFIXA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 May 2010 04:23:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

Artem reported on bko#15918 that on his machine ahci probing takes too
long (well, if you ask me, that's not too long but anyways).  This is
caused by CAP_SSS disabling parallel scan.  The code was added by
Arjan in commit 886ad09fc83342aa1c5a02a0b6d3298b78a8067f.  There is a
module parameter to skip this but I'm curious whether the change was
based on an actual problem as on most PC hardware by the time ahci
driver kick in, the BIOS has spun up everything already.

Thanks.

-- 
tejun
