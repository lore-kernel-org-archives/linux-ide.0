From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/6] SATA use ACPI methods for PM
Date: Fri, 2 Dec 2005 10:15:04 -0800
Message-ID: <20051202101504.27d0dfc0.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:35464 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750894AbVLBSOF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 13:14:05 -0500
In-Reply-To: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com


more comments:

Yes, the patch still contains some debugging code.
If you try it out and have problems, please give me as much of
the debug output as possible.  It is likely that I will also
want to see your ACPI tables.  To dump those, use
'acpidump' from the latest pmtools release at:
  http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

The patch series is available at:
  http://www.xenotime.net/linux/SATA/2.6.15-rc/

---
~Randy
