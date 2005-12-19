From: James Steward <james.steward@dynamicratings.com>
Subject: Execute from CF causes segmentation faults
Date: Mon, 19 Dec 2005 10:47:27 +1000
Message-ID: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from WTCGW.WTC.COM.AU ([203.44.93.226]:32946 "EHLO
	wtcnt4gw.wtc.com.au") by vger.kernel.org with ESMTP id S965308AbVLRXrg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Dec 2005 18:47:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>

G'day all,

The message below is a response from Russell King on the arm 
linux mailing lists regarding a problem I encountered, and as
it turns out has been encountered before.  I'm not sure if anyone
from the IDE development group is working on this but as it is
more ide specific it may be best handled by some clever guru 
from this mail list. 

The symptom I see is that executing code from a CF disk causes
SEGVs and other nasties.  The workaround is to add a kernel
command line arg "cachepolicy=writethrough".  This is seen as a
bit of a bandaid and not a "good" solution.

Could someone please take a look?

Regards,
James.


On Thu, Dec 01, 2005 at 01:44:59PM +1300, Charles Manning wrote:
> Something that confuses me lightly is why this problem should exist at
> all.
>
> It seems that the problem is caused by stale data in the cache.
> Surely cache data should never be stale (ie. Anything in the cache
> should be current).

No.  I think what is happening is:
* the page we submit to the block layer has some cache lines already
  associated with the kernel mapping.
* the IDE driver uses PIO to read from CF and hits these cache lines
  making them dirty.
* the page is then mapped into userspace via a page fault.
* userspace reads the page.  Because some of the data is sitting in
  the cache corresponding with the kernel mapping of the page,
  userspace doesn't see the up to date data until later.

> It also seems odd to me that this requires fixes at the block driver
> level. I'd have thought this would get resolved at the page cache
> level, or fs level at absolute lowest.

If you do it there, you hurt DMA performance.  The DMA model ensures
cache coherency.  The IDE PIO IO model does not.

Basically, the problem stems from IDE PIO IO not providing the same
cache guarantees as other block device drivers do. 
