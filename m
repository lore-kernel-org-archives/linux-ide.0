From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Thu, 8 May 2008 17:28:59 -0700
Message-ID: <20080508172859.4b0cd9af@appleyard>
References: <20080508161008.59361de5@appleyard>
	<20080508233713.GB15377@srcf.ucam.org>
	<20080508163555.51380949@appleyard>
	<20080509001458.GA16082@srcf.ucam.org>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10262 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbYEIAgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 May 2008 20:36:21 -0400
In-Reply-To: <20080509001458.GA16082@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 9 May 2008 01:14:58 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, May 08, 2008 at 04:35:55PM -0700, Kristen Carlson Accardi wrote:
> > On Fri, 9 May 2008 00:37:13 +0100
> > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > Just out of interest, is this set on laptop bays? (Are any of those even 
> > > native SATA yet?)
> > 
> > I haven't seen any yet that are.  Most of them are PATA.  I expect
> > that will change in the future.
> 
> Yeah. My vague concern would be that on laptops, we can probably power 
> down the port even if it's declared as being hotplug capable - we'll 
> probably get an out of band signal from ACPI anyway. Not an issue at the 
> moment, but possibly something we'll hit in future.
> 

well - when drive bays on laptops are able to be controlled by
AHCI, they may not actually use _EJ0 or send notifications anymore, 
since ACPI will not longer be necessary for hotplugging.  We'll have 
to see what happens.
