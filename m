From: "Peer Chen" <pchen@nvidia.com>
Subject: RE: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Mon, 14 May 2007 16:14:22 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B13B96E68@hkemmail01.nvidia.com>
References: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net> <46445833.7050707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate01.nvidia.com ([216.228.112.170]:13308 "EHLO
	HQEMGATE01.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbXENISA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 04:18:00 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46445833.7050707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun,
The future nvidia chips are all base on AHCI and also they can support
compatible mode,but current sata_nv have the bug with compatible mode
for AHCI controller,we need to modify the sata_nv driver then submit the
patch. Before that,if users load the sata_nv driver for our AHCI
controllers,they will encounter that bug.


BRs
Peer Chen

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, May 11, 2007 7:49 PM
To: akpm@linux-foundation.org; Peer Chen
Cc: jeff@garzik.org; linux-ide@vger.kernel.org
Subject: Re: [patch 08/20] drivers/ata: remove the wildcard from sata_nv
driver

akpm@linux-foundation.org wrote:
> From: "Peer Chen" <pchen@nvidia.com>
> 
> Because nvidia SATA controllers onward base on AHCI, so wildcard in
sata_nv
> driver is unnecessary.  Also the wildcard sometimes cause sata_nv
driver to
> be loaded for AHCI controllers,which is not as expected.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Peer Chen, are you sure we don't miss any existing devices by doing
this?  Also, what would future nvidia chips look like?  AHCI only or
dual mode similar ICHs?  If compatible mode is going to be supported &&
there is no switch we can mangle from PCI quirks to put it into AHCI
mode, we might wanna keep PCI_CLASS_STORAGE_IDE assuming compatible mode
interface remains similar.

Thanks.

-- 
tejun
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
