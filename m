From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Wed, 7 Jun 2006 12:42:53 +0100
Message-ID: <20060607114253.GA15531@srcf.ucam.org>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy> <4484D244.3010905@goop.org> <1149634494.13089.53.camel@whizzy> <44861109.7090502@goop.org> <1149639412.13089.85.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:62173 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750998AbWFGLnH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jun 2006 07:43:07 -0400
Content-Disposition: inline
In-Reply-To: <1149639412.13089.85.camel@whizzy>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Tue, Jun 06, 2006 at 05:16:52PM -0700, Kristen Accardi wrote:

> Using the eject file won't help for a couple of other reasons besides
> just the name change.  First, it requires that the device be present at
> boot.  Second, AFAIK it just calls the device's _EJ0 method, which I
> don't think is really the only thing that is needed here.  I think we
> also need a generic way to do this without using the ibm driver.  You
> could scan the acpi namespace for IDE controllers based on checking for
> some methods that are used only in IDE or SATA devices and write a acpi
> driver to handle insert/remove events, but it seems like for device
> hotplug though you'd still somehow need to rescan from ide.  To me it
> seems unwise to do anything outside the ide subsystem other than notify
> of an event and call some handler or something.

Does ejecting/docking not generate an IDE bus rescan notification? I've 
got hacky code to support that for SATA hardware, but it's not currently 
usable for PATA. Once the PATA libata code has settled down a little, 
I'll look into that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
