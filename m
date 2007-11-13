From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Tue, 13 Nov 2007 09:16:30 -0500
Message-ID: <4739B1BE.7080109@rtr.ca>
References: <471C6C44.2030607@gmail.com> <471CEDD4.5040201@garzik.org> <471D25D0.9020702@rtr.ca> <47397784.9070205@tw.ibm.com> <47397CC0.1070401@tw.ibm.com> <4739AB5B.7000703@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2271 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839AbXKMOQb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Nov 2007 09:16:31 -0500
In-Reply-To: <4739AB5B.7000703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> ..
> NAK.  There's no guarantee that the next command after an error
> will always be REQUEST_SENSE.   Or is there?
> 
> I think we should just ignore the ERR bit when DRQ is set for PACKET 
> command.
> Period.  Possibly only for tape drives (since they all seem to do this),
> and maybe not for non-tape drives.
..

Note also that if we already *know* that this ia an ATAPI device,
then we *know* that it will accept the PACKET opcode without error,
so there is no reason to even look at the ERR bit until after
the packet CDB has been transferred.

But I still think this should only apply to tapes for now.
