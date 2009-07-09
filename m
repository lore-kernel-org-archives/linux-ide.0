From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IN_BYTE and OUT_BYTE replacement
Date: Thu, 9 Jul 2009 13:46:36 +0100
Message-ID: <20090709134636.24e7d226@lxorguk.ukuu.org.uk>
References: <327262546.20090709142830@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53416 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756632AbZGIMpb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jul 2009 08:45:31 -0400
In-Reply-To: <327262546.20090709142830@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

> Is there any way to reproduce this behavior in libata other than
> redefining ioread8/iowrite8?

For the cases where hardware so far has needed this there are higher
level abstractions. It depends what cases the jasper h/w needs it for.

If you are using the SFF taskfile style interface then

	->sff_dev_select
	->sff_tf_load
	->sff_tf_read
	->sff_exec_command
	->sff_check_status
	->sff_check_altstatus
	->sff_irq_clear
	->sff_data_xfer

And for DMA

	->bmdma_setup
	->bmdma_start
	->bmdma_stop
	->bmdma_status

which are mostly just I/O operations.

Abstracting at this higher level helps performance by avoiding huge
numbers of indirect function calls through pointers.


However the reset logic isn't cleanly separated so might need a bit of
work if that is a problem.

It's hard to tell without more info whether they do the write on every
access because they can't just do it on the ones that need it or because
they need to do it each time.
