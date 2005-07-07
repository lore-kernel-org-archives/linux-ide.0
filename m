From: Christoph Lameter <christoph@lameter.com>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 09:32:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0507070930220.5875@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <20050707162442.GI21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from graphe.net ([209.204.138.32]:13974 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261410AbVGGQcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 12:32:55 -0400
In-Reply-To: <20050707162442.GI21330@wotan.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Andi Kleen wrote:

> On Thu, Jul 07, 2005 at 09:21:55AM -0700, Christoph Lameter wrote:
> > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > 
> > > Without this patch a dual Xeon EM64T machine would oops on boot
> > > because the hwif pointer here was NULL. I also added a check for
> > > pci_dev because it's doubtful that all IDE devices have pci_devs.
> > 
> > Here is IMHO the right way to fix this. Test for the hwif != NULL and
> > test for pci_dev != NULL before determining the node number of the pci 
> > bus that the device is connected to. Maybe we need a hwif_to_node for ide 
> > drivers that is also able to determine the locality of other hardware?
> 
> Hmm? Where is the difference? 

node = -1 if the node cannot be determined.

> This is 100% equivalent to my code except that you compressed
> it all into a single expression.

My patch consistently checks for hwif != NULL and pci_dev != NULL. 
There was someother stuff in your patch. This patch does not add any 
additional variables and is more readable.
