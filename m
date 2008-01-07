From: Mark Lord <liml@rtr.ca>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Mon, 07 Jan 2008 10:15:56 -0500
Message-ID: <4782422C.8020202@rtr.ca>
References: <4781F008.9070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1207 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbYAGPP5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jan 2008 10:15:57 -0500
In-Reply-To: <4781F008.9070404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, guys.
> 
> We still have three problems with ADMA.
> 
> * hard lockup during resume
> * occasional hard lockup after hotplug or other erros (probably related
> to the above?)
> * occasional timeout of FLUSH after NCQ writes
> 
> I think we should disable ADMA for 2.6.24 and -stable for now.  What do
> you guys think?
..

Heck, given the active vendor neglect here,
I'm surprised we even bother with it at all!

Cheers
