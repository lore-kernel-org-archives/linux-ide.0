From: Tejun Heo <tj@kernel.org>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
   question)
Date: Sun, 03 May 2009 11:07:25 +0900
Message-ID: <49FCFC5D.5050303@kernel.org>
References: <E1LzLgA-0004j6-9W@closure.thunk.org> <49F90CA2.4080602@garzik.org> <20090430083309.437f9248@lithium.local.net> <49F95719.10701@kernel.org> <20090430144702.46415b90@lxorguk.ukuu.org.uk> <20090430153508.GA10704@linux.intel.com> <20090430154701.GA27737@srcf.ucam.org> <49FA5519.9000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55433 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbZECCHo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 May 2009 22:07:44 -0400
In-Reply-To: <49FA5519.9000107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alex Buell <alex.buell@munted.org.uk>, Jeff Garzik <jeff@garzik.org>, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Matthew Garrett wrote:
>> On Thu, Apr 30, 2009 at 08:35:08AM -0700, Matthew Wilcox wrote:
>>> On Thu, Apr 30, 2009 at 02:47:02PM +0100, Alan Cox wrote:
>>>>> So, at the point of driver load, there just isn't much we can do about
>>>>> the missing ABAR.  It's sad.  Dunno why some laptop manufacturers
>>>>> still program the thing into piix mode.  :-(
>>>> Forcing out of PIIX mode would need to go into the PCI quirks and be a
>>>> boot option not a module one - at that point its doable as a header
>>>> quirk.
>>> I think Matthew Garrett already has code to do this.
>>
>> Yeah, but some testers reported that it broke after using it for a
>> while. The most recent version I have is this:
> 
> We should likely have something like this in the kernel, but it should
> default to off. For one thing, some machines seem to have BIOS code that
> tries to poke the controller for some reason during suspend/shutdown
> events, etc. which would likely go nuts if the controller was
> unexpectedly in AHCI mode..

Maybe, I don't know.  Matthew's patch seems clean enough for upstream
inclusion but I'm always a bit put off about including some feature
which should default to off.  It never gets used and tested a lot thus
ending up broken on many configurations further fueling the vicious
cycle.  After the initial interested users passed, it just becomes
dead weight none uses which often is quite annoying when trying to
change code around it because nobody at that point knows on which
configurations it worked and even whether it not working is a
regression or expected behavior.

Given the wide variety of ich motherboards out in the wild and all
their different BIOS revisions and the fact that NCQ or not doesn't
make whole lot of difference for most desktop workload, I think why
bother.  A few years back some vendors seemed to use it for product
differentiation but nowadays it's just silly to disable ahci for that
purpose.

Thanks.

-- 
tejun
