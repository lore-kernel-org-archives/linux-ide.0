From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Thu, 11 May 2006 18:16:35 +0100
Message-ID: <1147367796.26130.77.camel@localhost.localdomain>
References: <11473536881889-git-send-email-htejun@gmail.com>
	 <1147357322.26130.17.camel@localhost.localdomain>
	 <44634CB6.80804@gmail.com>
	 <1147362385.26130.42.camel@localhost.localdomain>
	 <44635C29.6080903@gmail.com>
	 <1147363974.26130.56.camel@localhost.localdomain>
	 <446361F3.4040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20973 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030372AbWEKRGd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 13:06:33 -0400
In-Reply-To: <446361F3.4040505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Gwe, 2006-05-12 at 01:10 +0900, Tejun Heo wrote:
> > documented) to drop any pending interrupt once it is masked, thus you
> > would take the interrupt once (or maybe 2 or 3 times in weird obscure
> > corner cases on a pentium II SMP box) and then no more.
> 
> So, they will drop interrupt after several unhandled IRQs at most even
> if the driver doesn't read TF status register to clear it, right?

Yes. The IRQ is no longer asserted at source so will not be re-triggered

