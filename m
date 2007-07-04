From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [info] What's in Jeff's libata-dev inbox?
Date: Wed, 04 Jul 2007 16:19:05 +0800
Message-ID: <468B57F9.1040804@tw.ibm.com>
References: <20070702151639.GA10948@havoc.gtf.org> <20070702165327.2646a761@the-village.bc.nu> <46892AEF.8@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:40603 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbXGDITU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:19:20 -0400
In-Reply-To: <46892AEF.8@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mikael Pettersson <mikpe@it.uu.se>

Jeff Garzik wrote:
>>> I have patches from Alan (pata_sis FIFO whack, pata_dma option), Tejun,
>>> Albert and Kristen still to be reviewed.  Will get to those on Friday,
>>> after the July 4th US holiday.tions(-)
> 
> 
> Just to be more specific, my to-review inbox contains:
> 
> Alan: pata_sis FIFO whack, pata_dma option
> 
> Tejun: PMP patchbomb
> 
> Albert: irq_on/off restructure, irq-driven PIO to wq, minor PIO fixes
> 

Please ignore the "irq-driven PIO to wq" patchset; it's not ready.
For the other two patchsets, I'll rediff and resend for your review.

--
albert


