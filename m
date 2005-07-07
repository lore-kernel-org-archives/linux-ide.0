From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 18:46:18 +0200
Message-ID: <58cb370e05070709461d9a6d9c@mail.gmail.com>
References: <20050706133052.GF21330@wotan.suse.de>
	 <Pine.LNX.4.62.0507070912140.27066@graphe.net>
	 <20050707162442.GI21330@wotan.suse.de>
	 <Pine.LNX.4.62.0507070930220.5875@graphe.net>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.193]:51821 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261484AbVGGQqT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Jul 2005 12:46:19 -0400
Received: by nproxy.gmail.com with SMTP id x37so64817nfc
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 09:46:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507070930220.5875@graphe.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On 7/7/05, Christoph Lameter <christoph@lameter.com> wrote:
> On Thu, 7 Jul 2005, Andi Kleen wrote:
> 
> > On Thu, Jul 07, 2005 at 09:21:55AM -0700, Christoph Lameter wrote:
> > > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > >
> > > > Without this patch a dual Xeon EM64T machine would oops on boot
> > > > because the hwif pointer here was NULL. I also added a check for
> > > > pci_dev because it's doubtful that all IDE devices have pci_devs.
> > >
> > > Here is IMHO the right way to fix this. Test for the hwif != NULL and
> > > test for pci_dev != NULL before determining the node number of the pci
> > > bus that the device is connected to. Maybe we need a hwif_to_node for ide
> > > drivers that is also able to determine the locality of other hardware?
> >
> > Hmm? Where is the difference?
> 
> node = -1 if the node cannot be determined.
> 
> > This is 100% equivalent to my code except that you compressed
> > it all into a single expression.
> 
> My patch consistently checks for hwif != NULL and pci_dev != NULL.
> There was someother stuff in your patch. This patch does not add any
> additional variables and is more readable.

seconded but hwif != NULL still just hides some other issue

* hwifs and drives are not allocated dynamically
* drive->hwif is initialized to hwif for every hwif very early in the
driver initialization
