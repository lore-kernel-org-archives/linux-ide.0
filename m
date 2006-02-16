From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] libata: use single unsigned int xfer_mask
Date: Thu, 16 Feb 2006 14:46:49 +0000
Message-ID: <1140101209.28094.26.camel@localhost.localdomain>
References: <11400989462656-git-send-email-htejun@gmail.com>
	 <43F48BB9.5080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:13493 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932262AbWBPOnj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:43:39 -0500
In-Reply-To: <43F48BB9.5080100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, albertcc@tw.ibm.com, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Iau, 2006-02-16 at 23:27 +0900, Tejun Heo wrote:
> * In the second patch, ata_timing_comput() is left to use XFER_* values 
> as arguments and for calculation purposes.  As this function has no 
> in-tree user yet, I couldn't determine how to transform it.  It's also 
> quite possible that simply continuing to use XFER_* values are okay.

Grab my pata patch and you'll find a collection of users. The function
turns a given mode into timing data and is basically a port of the handy
function ide_compute_timing from the original IDE code. It needs to be
passed a mode so XFER_ is the logical thing to pass it anyway.

Alan

