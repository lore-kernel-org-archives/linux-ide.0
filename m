From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
Date: Mon, 18 May 2015 10:06:37 +0200
Message-ID: <20150518080637.GM10428@rric.localhost>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
 <20150517073331.GA30529@agordeev.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0058.outbound.protection.outlook.com ([157.56.111.58]:54244
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751223AbbERIG5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 May 2015 04:06:57 -0400
Content-Disposition: inline
In-Reply-To: <20150517073331.GA30529@agordeev.usersys.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Robert Richter <rric@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tejun Heo <tj@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 17.05.15 08:33:32, Alexander Gordeev wrote:
> You enable MSI-X for a single chip, but introduce a change to the
> generic AHCI code.
> 
> In general MSI-X case, what makes you believe that IRQ vectors are
> assigned continuously?
> 
> (Interface ahci_host_activate() kinda expects a contiguous vector
> range, but MSI-X does not guarantee that at all).

That's the reason why I only enable single interrupt mode which our
hardware supports.

To not break other chips by this generic code change, there are the
following precautions:

 * Interrupt ranges are not enabled at all.

 * Only single interrupt mode is enabled for msix cap devices. These
   devices require a single port only or a total number of int entries
   less than the total number of ports. In this case only one
   interrupt will be enabled.

 * During the discussion with Tejun we agreed to change the init
   sequence from msix-msi-intx to msi-msix-intx. Thus, if a device
   offers msi and init does not fail, the msix init code will not be
   executed. This is equivalent to current code.

With this, the code only setups single mode msix as a last resort if
msi fails. No interrupt range is enabled at all. Only one interrupt
will be enabled. Considering all this I think your concerns are
addressed.

Also, the code can be easily extended for other devices and thus
should be generic from the beginning.

-Robert
