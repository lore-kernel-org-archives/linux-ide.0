From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ipr SATA problems in 2.6.20
Date: Tue, 16 Jan 2007 17:45:56 -0500
Message-ID: <45AD55A4.50208@pobox.com>
References: <45AD50AD.2040700@linux.vnet.ibm.com> <20070116224115.50d29cf7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59343 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbXAPWqE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 17:46:04 -0500
In-Reply-To: <20070116224115.50d29cf7@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: brking@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Alan wrote:
>> The other oddity I've been seeing is that I am getting zero length commands,
>> such as TEST_UNIT_READY with a dma_dir of DMA_FROM_DEVICE. Shouldn't this be
>> DMA_NONE? I'm still tracking this down.
> 
> I was looking at a PATA trace that was looking the same 2 days ago and
> couldn't figure what was going on. 

Tejun recently updated the CDB length areas of the code.  I bet it's 
either a bug somewhere in there, or the SCSI layer isn't passing us 
proper command lengths in a case or two.

Additional traces (starting with SCSI command, before it hits libata) 
would be helpful.

	Jeff


