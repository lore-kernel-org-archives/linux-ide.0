From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 3
Date: Thu, 27 Sep 2007 18:55:06 +0100
Message-ID: <20070927175505.GA14476@srcf.ucam.org>
References: <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <20070927102659.2cacae14.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070927102659.2cacae14.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Sep 27, 2007 at 10:26:59AM -0700, Kristen Carlson Accardi wrote:

> 1.  How does it handle things when you have a bay that is located behind
> a dock and the dock ejects?  In the acpi bay driver, I use the mechanism
> that the dock driver exports to get undock notifications so that the bay
> can eject as well.

Hm. I'd been working on the assumption that ejecting the doc would 
trigger the bay notifications as well, but I've got no hardware here 
with those capabilities so it's kind of hard to check...

> 2.  What if someone wants to use their bay to charge their battery?  While
> I never bothered to implement this in acpi/bay.c, nothing ever prevented
> anyone from adding that support to the driver, where now it is prevented
> since this driver and another cannot coexist.

The spec seems to imply that even if the drive hotswap bay and the 
battery bay are physically the same, they're logically distinct. 10.2.1 
specifies that the battery bay should always be considered present, and 
that any insertion notification will be generated from the battery bay 
rather than the drive bay (so Notify (BAT1, 0x81) rather than Notify 
(_SB.MISC.OTHR.BONG.PRIM.SLAV, 0x81)). My code will only grab the 
latter notification, not the former.

I /suspect/ that _STA on the bay device won't return true if there's a 
battery in there, and so we aren't expected to call the _EJ0 method if 
the user wants to remove a battery. But I'm also lacking hardware to 
test this one, so it's possible that I'm utterly wrong :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
