From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata git tree, mbox queue status and contents
Date: Fri, 3 Aug 2007 17:20:40 +0100
Message-ID: <20070803172040.52853316@the-village.bc.nu>
References: <46B35344.3090208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56962 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753923AbXHCQOD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 12:14:03 -0400
In-Reply-To: <46B35344.3090208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

> * Alan: IORDY handling -- upstream whenever Alan is happy

I'm happy with it from testing. Just a little worried about it going
upstream mid -rc as it could have a weird side effect somewhere. I've
verified an original pre ATA IDE drive with it too now 8)

> * Alan: ACPI checks for 80wire cable -- upstream whenever Alan is happy

Happy

> * Albert: irq_on/off.  Really need to give this some thought.  Not sure 
> I like where this model is going.  Polling and twiddling irq on/off 
> should be kept to a minimum, because it's sorta an admission that the 
> host state machine has broken down, and we need to bandaid.  Its a 
> bandaid not a root-cause solution.

I think of it more as an admission that the IDE design is lacking in a
few areas. No suprise as its an emulation of a 15 year old interface that
was normally used polled.

> * Ben Collins: cleanup HPA support.  Need to review and see what's 
> needed today, from this patch.

We need to track the HPA case Bartlomiej is working on with old IDE - one
drive out there is reporting its geometry wrong.
