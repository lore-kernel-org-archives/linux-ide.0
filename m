From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] PCI: export __pci_reenable_device()
Date: Tue, 10 Jul 2007 09:17:09 -0700
Message-ID: <20070710161709.GB5421@kroah.com>
References: <20070710063605.GA21994@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:43765 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbXGJQSH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 12:18:07 -0400
Content-Disposition: inline
In-Reply-To: <20070710063605.GA21994@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

On Tue, Jul 10, 2007 at 03:36:05PM +0900, Tejun Heo wrote:
> Some odd ACPI implementations choke if certain controller is disabled
> when ACPI suspend is invoked but we still need to make sure the PCI
> device is enabled during resume.  Simply using pci_enable_device()
> unbalances device enable count.  Export __pci_reenable_device().

We should rename it to pci_reenable_device() instead of the leading "__"
as that should denote an internal-only function.

Care to do that and respin this series?

thanks,

greg k-h
