From: Joerg Roedel <joro@8bytes.org>
Subject: Re: DMAR error messages after 'shutdown -r'.
Date: Wed, 16 Mar 2016 18:46:08 +0100
Message-ID: <20160316174608.GF2195@8bytes.org>
References: <38172.1455047940@turing-police.cc.vt.edu>
 <20160216164745.GZ18805@8bytes.org>
 <22265.1457386917@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:41889 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbcCPRqL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Mar 2016 13:46:11 -0400
Content-Disposition: inline
In-Reply-To: <22265.1457386917@turing-police.cc.vt.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Mar 07, 2016 at 04:41:57PM -0500, Valdis.Kletnieks@vt.edu wrote:
> 
> lspci says:
> 00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04)
> 
> Not sure why I only see it on reboots - that means that when powering up, the kernel
> gets handed a device config it likes, but when rebooting, something is leaving the
> device in a config the kernel doesn't want to see.

Okay, so the BIOS defines one RMRR entry:

	DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff

But the device-scope doesn't seem to match any existing devices in your
system. At least no device gets the RMRR mappings later on.

That doesn't really matter, as the the fault-address of 0xcdacd000 is
outside of the defined RMRR range anyway.

Looking at the fault-address as system physical, is would be in this
range of system memory:

	BIOS-e820: [mem 0x00000000cd99b000-0x00000000ce3a0fff] reserved

Which is reserved for BIOS use. This looks very much like a missing RMRR
entry for that range, that has the sata controler in its device scope.


	Joerg

