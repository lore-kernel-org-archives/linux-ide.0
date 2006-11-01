From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_vsc: Add MSI support to sata_vsc driver (resubmit)
 (fixed attachment)
Date: Tue, 31 Oct 2006 20:52:03 -0500
Message-ID: <4547FDC3.4080502@garzik.org>
References: <DE99218BE995814CA3B82E6AD9939C3C114D0F@azsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:469 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946307AbWKABwF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 20:52:05 -0500
In-Reply-To: <DE99218BE995814CA3B82E6AD9939C3C114D0F@azsmsx415.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Cc: linux-ide@vger.kernel.org

Wolstenholme, Daniel E wrote:
> Ok, hopefully I can get the attachment right here.
> 
> Here's a resubmission of my MSI patch for the sata_vsc driver.
> 
> I've added a new vsc_sata_host_priv data structure (basically copied
> from the sata_mv driver) which has an hp_flags bitfield with a bit to
> indicate whether MSI is being used. This is used in the new
> vsc_sata_host_stop() routine to call
> pci_disable_msi() if MSI is on, pci_intx() if not.
> 
> Signed-off-by: Daniel Wolstenholme <daniel.e.wolstenholme@intel.com>

ACK the patch technical content.

Unfortunately, the patch was corrupted, and tabs were converted to 
spaces, which makes it impossible to apply the patch.


