From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Fri, 9 May 2008 01:14:58 +0100
Message-ID: <20080509001458.GA16082@srcf.ucam.org>
References: <20080508161008.59361de5@appleyard> <20080508233713.GB15377@srcf.ucam.org> <20080508163555.51380949@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:37129 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbYEIAPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 20:15:14 -0400
Content-Disposition: inline
In-Reply-To: <20080508163555.51380949@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 08, 2008 at 04:35:55PM -0700, Kristen Carlson Accardi wrote:
> On Fri, 9 May 2008 00:37:13 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Just out of interest, is this set on laptop bays? (Are any of those even 
> > native SATA yet?)
> 
> I haven't seen any yet that are.  Most of them are PATA.  I expect
> that will change in the future.

Yeah. My vague concern would be that on laptops, we can probably power 
down the port even if it's declared as being hotplug capable - we'll 
probably get an out of band signal from ACPI anyway. Not an issue at the 
moment, but possibly something we'll hit in future.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
