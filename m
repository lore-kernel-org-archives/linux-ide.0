From: Andi Kleen <ak@suse.de>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 18:24:42 +0200
Message-ID: <20050707162442.GI21330@wotan.suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:55688 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261355AbVGGQYo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 12:24:44 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 09:21:55AM -0700, Christoph Lameter wrote:
> On Wed, 6 Jul 2005, Andi Kleen wrote:
> 
> > Without this patch a dual Xeon EM64T machine would oops on boot
> > because the hwif pointer here was NULL. I also added a check for
> > pci_dev because it's doubtful that all IDE devices have pci_devs.
> 
> Here is IMHO the right way to fix this. Test for the hwif != NULL and
> test for pci_dev != NULL before determining the node number of the pci 
> bus that the device is connected to. Maybe we need a hwif_to_node for ide 
> drivers that is also able to determine the locality of other hardware?

Hmm? Where is the difference? 

This is 100% equivalent to my code except that you compressed
it all into a single expression.

The former one was more readable.

-Andi

