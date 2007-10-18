From: Martin Rogge <marogge@onlinehome.de>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Fri, 19 Oct 2007 00:39:10 +0200
Message-ID: <200710190039.10568.marogge@onlinehome.de>
References: <200710142211.03382.marogge@onlinehome.de> <200710170014.28037.bzolnier@gmail.com> <200710172115.13068.marogge@onlinehome.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OC+FHBr+xUvIJdY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:62809 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758110AbXJRWjT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 18:39:19 -0400
In-Reply-To: <200710172115.13068.marogge@onlinehome.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

--Boundary-00=_OC+FHBr+xUvIJdY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 October 2007 21:15:12 Martin Rogge wrote:
> On Wednesday 17 October 2007 00:14:26 Bartlomiej Zolnierkiewicz wrote:
> > Martin, could you run git-bisect (http://kerneltrap.org/node/11753 -
> > sorry for not explaining the procudure myself but Linus did it really
> > well) starting with:
> >
> > 	git bisect good 688a87d145e04f6761c63e7f2e19fd9b3e4ca060
> > 	git bisect bad 826a1b6502d0d1d67fc41043fc831e90f2ef5835
> >
> > The "good" one is the last commit before cmd64x changes and the "bad" one
> > is the first commit after them.  Since there is only 5 commits in between
> > it should be really quick find the bad one (worst-case: 3
> > recompiles/reboots).
>
> I'll do my best. I appear to have git 1.5.2.2 on my machine, but I've never
> used it. In the old days we used not to have such luxury!
>
> Give me a few days. I shall report back.
>
> cu Martin

OK, the jury is in. This is the result of git bisecting:

66602c83dcb6a5d82772d88ae7a32cd4a1213528 is first bad commit
commit 66602c83dcb6a5d82772d88ae7a32cd4a1213528
Author: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date:   Sat May 5 22:03:50 2007 +0200

    cmd64x: use interrupt status from MRDMODE register (take 2)

    Fold the parts of the ide_dma_end() methods identical to __ide_dma_end() 
into a
    mere call to it.
    Start using faster versions of the ide_dma_end() and ide_dma_test_irq() 
methods
    for the PCI0646U and newer chips that have the duplicate interrupt status 
bits
    in the I/O mapped MRDMODE register, determing what methods to use at the 
driver
    load time. Do some cleanup/renaming in the "old" ide_dma_test_irq() method 
too.

    Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

:040000 040000 e9596b9ff362a0bec73601baac84025f106846f9 
531d19102f9ff54ff870618c742ad81d930af533 M      drivers

I shall also attach the file BISECT_LOG. Hope this gives you some valuable 
input.

cu Martin


--Boundary-00=_OC+FHBr+xUvIJdY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="BISECT_LOG"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="BISECT_LOG"

git-bisect start
# good: [688a87d145e04f6761c63e7f2e19fd9b3e4ca060] sl82c105: DMA support code cleanup (take 4)
git-bisect good 688a87d145e04f6761c63e7f2e19fd9b3e4ca060
# bad: [826a1b6502d0d1d67fc41043fc831e90f2ef5835] aec62xx: fix PIO/DMA setup issues
git-bisect bad 826a1b6502d0d1d67fc41043fc831e90f2ef5835
# good: [7accbffdb8163a59c7bdd3e4eb9a391198979522] cmd64x: add/fix enablebits (take 2)
git-bisect good 7accbffdb8163a59c7bdd3e4eb9a391198979522
# bad: [66602c83dcb6a5d82772d88ae7a32cd4a1213528] cmd64x: use interrupt status from MRDMODE register (take 2)
git-bisect bad 66602c83dcb6a5d82772d88ae7a32cd4a1213528
# good: [5826b318aa02e81575c352ca26f00773c999795b] cmd64x: procfs code fixes/cleanups (take 2)
git-bisect good 5826b318aa02e81575c352ca26f00773c999795b

--Boundary-00=_OC+FHBr+xUvIJdY--
