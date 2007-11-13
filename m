From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Tue, 13 Nov 2007 12:24:45 -0500
Message-ID: <4739DDDD.7060305@rtr.ca>
References: <471C6C44.2030607@gmail.com>	<471CEDD4.5040201@garzik.org>	<471D25D0.9020702@rtr.ca>	<47397784.9070205@tw.ibm.com>	<47397CC0.1070401@tw.ibm.com>	<4739AB5B.7000703@rtr.ca> <20071113151459.086ffcae@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2444 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbXKMRYr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Nov 2007 12:24:47 -0500
In-Reply-To: <20071113151459.086ffcae@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> NAK.  There's no guarantee that the next command after an error
>> will always be REQUEST_SENSE.   Or is there?
> 
> For that device over ATAPI I believe the guarantee is there, the same as
> for SCSI.
..

Even for SG_IO w/o requesting sense data?
