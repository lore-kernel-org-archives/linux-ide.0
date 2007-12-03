From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch] ata: ahci: Enclosure Management via LED rev2
Date: Mon, 3 Dec 2007 09:42:36 -0800
Message-ID: <20071203094236.7c85522c@appleyard>
References: <20071129121925.7d178915@appleyard>
	<20071130163443.2feabc5d@appleyard>
	<4751EE36.6050506@garzik.org>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6754 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbXLCRpH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 12:45:07 -0500
In-Reply-To: <4751EE36.6050506@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 01 Dec 2007 18:28:54 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Kristen Carlson Accardi wrote:
> > Enclosure Management via LED
> > 
> > This patch implements Enclosure Management via the LED protocol as
> > specified in AHCI specification.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > ---
> > This revision makes the change to the comment requested by Mark
> > Lord, fixes some bugs in the bit shifting for writing the new led
> > state, and implements a show function so that led status can be
> > read as well as written.
> 
> Overall looks pretty good, from a technical review perspective.
> 
> Two worries:
> 
> 1) exporting ata_scsi_find_dev(), and assuming a scsi device is 
> attached.  the latter can be fixed by a !NULL check (and should be),
> but its a bit of a layering violation since long term we want to make
> the SCSI simulator optional for all ATA devices.
> 
> 2) vaguely related to #1, I'm not so sure the attributes should be 
> implemented directly in ahci.  if this __or something like it__
> appears on non-Intel hardware, the code should be somewhere more
> generic.
> 

When I first started developing this patch, I did have a more generic
approach - It adds lots of complexity that isn't needed for this simple
protocol, and one of the problems I encountered was that for different
EM protocols, you'd probably want to have a different set of attributes
defined.  Also, even using the same protocol, you may have hardware
that supports more attributes.  For example, in the case of this LED
protocol, some implementations may support the Activity LED (software
controlled), and some may not.  For protocols like SGPIO, they have a
lot of attributes defined by the spec, but I'm guessing hardware may
not support all of them.  When I tried to abstract hardware and
protocol away and make some kind of generic enclosure management
framework, it turned into this big ordeal.  So, I can keep going along
those lines, but to me it started to seem silly since I had no other
hardware that I knew of that was going to be helped by all this.  I
thought maybe the right thing to do was to keep it simple and then wait
for other the hardware to appear.
