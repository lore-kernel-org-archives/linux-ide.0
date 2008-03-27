From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 22:00:13 +0000
Message-ID: <20080327220013.59692be4@core>
References: <12066128663306-git-send-email-htejun@gmail.com>
	<47EBDE84.1070802@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52895 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759380AbYC0WRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 18:17:20 -0400
In-Reply-To: <47EBDE84.1070802@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca

> Are we sure that it is ever the right thing to do to reissue a flush command?

The spec is pretty clear about this.

> I am worried that this might be much closer to the media error class of device 
> errors than something that will benefit from a retry of any type.

There are several cases it matters and there are some where it is going
to matter. RAID firmware is the obvious one but the upcoming joy is large
physical sector sizes where a read/modify/write may be required and fail
but the remaining sectors can be written or fired at spare blocks

> Also, I am unclear as to how we measure the progress of the device if the flush 
> command has failed?

The spec says that if a flush fails to write back a block then the
failed block is dropped from the cache. Thus you make progress and you
have a mechanism to report each failed LBA.

Alan
