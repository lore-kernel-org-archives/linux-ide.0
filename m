From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 09:38:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261462AbVGGQmv@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507070912140.27066@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Thu, 7 Jul 2005, Christoph Lameter wrote:
> 
> Here is IMHO the right way to fix this. Test for the hwif != NULL and
> test for pci_dev != NULL before determining the node number of the pci 
> bus that the device is connected to.

I think this is pretty unreadable.

If you make it use a trivial inline function for the thing, I think that 
would be ok, though.

Complex expressions are bad.

		Linus
