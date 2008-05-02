From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH 12/12] sata_mv NCQ-EH for FIS-based switching
Date: Fri, 2 May 2008 13:52:38 -0400
Message-ID: <20080502175238.GA30137@devserv.devel.redhat.com>
References: <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca> <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca> <481B0C9E.80008@rtr.ca> <da824cf30805020952g73ce5eabqdd5cd769286a90a6@mail.gmail.com> <da824cf30805020954md3c3450qe22edff7f037994a@mail.gmail.com> <481B538A.3030804@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55661 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755023AbYEBRxC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 13:53:02 -0400
Content-Disposition: inline
In-Reply-To: <481B538A.3030804@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Grant Grundler <grundler@google.com>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

On Fri, May 02, 2008 at 01:46:50PM -0400, Mark Lord wrote:
> >> include/asm-ia64/bitops.h:hweight64()
> ..
> 
> "hweight" ??  That's a nice "obvious" name for "count number of set bits".  

It is if you ever do any signal processing work ;)

H for Hamming.

Alan


