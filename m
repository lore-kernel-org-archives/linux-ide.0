From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_nv ADMA controller lockup investigation
Date: Thu, 15 Feb 2007 05:46:15 -0500
Message-ID: <45D439F7.3030604@garzik.org>
References: <45D3E1FF.3080606@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54868 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965843AbXBOKqS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 05:46:18 -0500
In-Reply-To: <45D3E1FF.3080606@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Allen Martin <AMartin@nvidia.com>, nas@arctrix.com, B.Steinbrink@gmx.de

Robert Hancock wrote:
> It's curious that only the post-cache-flush command is having issues,
> and normal NCQ operation seems fine. Maybe it's related to that tag 0
> being reused repeatedly?


If you take cache flush out of the equation, what happens when NCQ is 
enabled with a queue depth of 1 (to reproduce tag-0-used-repeatedly 
condition)?

	Jeff


