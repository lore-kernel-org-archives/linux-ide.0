From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Fri, 23 Nov 2007 12:46:38 -0500
Message-ID: <474711FE.8040805@rtr.ca>
References: <47463534.9010100@shaw.ca> <4746F02D.2060204@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D901053E8542@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1775 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbXKWRqk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 12:46:40 -0500
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901053E8542@EMPBEDEX.empirix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Morrison, Tom wrote:
> I am hopeful that the sata_mv has this bug (I proved that the
> problem I was experiencing was due to the sata_mv driver 
> with 3.75Gig or more of memory)...
>  
> I am on vacation for a week or more ...or I'd tell you today
> if it did have this bug!
..

Yeah, I kind of had your reports in mind when I asked that.  :)

On a related note, I now have lots of Marvell (sata_mv) hardware here,
and an Intel CPU/chipset box with physical RAM above the 4GB boundary.

Cheers
