From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Thu, 17 Feb 2011 16:36:49 +0000
Message-ID: <20110217163649.GC20662@srcf.ucam.org>
References: <20110216090548.GQ5778@Redstar.dorchain.net> <4D5C2974.4070608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35335 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab1BQQhD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 11:37:03 -0500
Content-Disposition: inline
In-Reply-To: <4D5C2974.4070608@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Joerg Dorchain <joerg@dorchain.net>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>

On Wed, Feb 16, 2011 at 02:45:56PM -0500, Jeff Garzik wrote:

> How is the assignment of the AHCI BAR handled?  Does this happen  
> automatically because it's an early fixup?
>
> That is traditionally the stumbling block...

Yes, because it's an early fixup the kernel should allocate it itself. 
It's small enough that I'd hope we don't have trouble finding one...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
