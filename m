From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: libata and DMA quirks
Date: Fri, 27 Jun 2008 16:41:34 +1000
Message-ID: <1214548895.8011.526.camel@pasglop>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59363 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057AbYF0IWm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 04:22:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Hi !

While doing a pmac libata PATA driver, I've been looking at some of the
info we have from Apple (mostly the Darwin code) and some interesting
stuff pops out.

The main one is that one their latest cell, they do the following
"workarounds" which I never implemented in drivers/ide/ppc/pmac.c but
I'd like to implement in the libata driver, unless you believe that is
unnecessary:

a) =EF=BB=BFFor any ATAPI DMA, If the transfer size is not a multiple o=
f 16
bytes, switch to PIO for this command.

b) Double buffer all ATAPI DMA reads. They allocate a 128K DMA buffer
and limit all requests to 128K. Then, they route all incoming DMAs to
that buffer and copy back to the original buffer on completion.

The comments in the code seem to indicate this has to do with "alignmen=
t
restrictions", unfortunately, I have no more infos so I don't know what
the actual underlying HW issues are.

I could use some tips as to how to implement these in the libata driver=
=2E
=46or a) I'm not sure about either overriding qc_prep or qc_issue and w=
hat
would be the consequence of changing tf.protocol there ? Among others,
qc_prep() would be after dma_map_sg has been performed, which is a
concern. I suppose I can ignore the DMA mapping, that would just be a
peformance issue.

Do you see anything else that could shoke on a change of protocol at
that stage ?

=46or b) I should be able to completely hide that within my qc_prep and
completion, by silently using a different DMA target. I suppose I can
use tf.command =3D=3D ATA_CMD_ID_ATAPI to differenciate with ATA comman=
ds.

How do I set the max request size with the block layer tho from a libat=
a
sub-driver ?

Thanks,

Cheers,
Ben.



