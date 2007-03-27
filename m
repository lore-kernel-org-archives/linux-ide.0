From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATA ACPI (was Re: Linux 2.6.21-rc5)
Date: Tue, 27 Mar 2007 14:48:18 -0400
Message-ID: <460966F2.4010307@garzik.org>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org> <4608B0CA.1040005@garzik.org> <Pine.LNX.4.64.0703271006340.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38234 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934161AbXC0SsV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 14:48:21 -0400
In-Reply-To: <Pine.LNX.4.64.0703271006340.6730@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Len Brown <lenb@kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Linus Torvalds wrote:
> 
> On Tue, 27 Mar 2007, Jeff Garzik wrote:
>> FWIW, I'm still leaning towards disabling libata ACPI support by default for
>> 2.6.21.
> 
> Hey, I'm not going to argue against anything that says "disable ACPI". Of 
> *course* it should be disabled if there aren't thousands of machines that 
> are in user hands that actually need it (and none that regress).

It's required to access data at all (BIOS-supplied password [un]locks 
disk), in a small minority of configurations.  It's strongly suggested 
for reliable suspend/resume, particularly on laptops, where libata ACPI 
support fixes some suspend/resume problems.

Some BIOSen also want to apply drive+board-specific errata workarounds. 
  That's OK, but ideally we should know about those in the kernel.

"none that regress" is the problem though.  Buggy tables, unexercised 
ACPI code paths, and in a few cases unexpected post-ACPI 
drive/controller behavior expose regressions.


> Anybody want to send me a patch?

Since everybody is OK with my plan, I'll send one today along with the 
rest of the post-vacation 2.6.21-rc bug fixes.

	Jeff


