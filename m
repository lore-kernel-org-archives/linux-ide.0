From: Mark Lord <liml@rtr.ca>
Subject: Re: Hot swapping drives
Date: Thu, 17 Apr 2008 20:31:10 -0400
Message-ID: <4807EBCE.9020004@rtr.ca>
References: <4807C1C1.4070808@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2438 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbYDRAbL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2008 20:31:11 -0400
In-Reply-To: <4807C1C1.4070808@sauce.co.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <richard@sauce.co.nz>
Cc: linux-ide@vger.kernel.org

Richard Scobie wrote:
> Apologies if this is the wrong list for this.
> 
> I have a SAS backplane filled with 16 SATA drives.
> 
> Assuming a drive is unmounted or failed and removed from an md array, is 
> it safe to directly pull the drive and insert a new one, or are there 
> other commands required in order to remove power from it first?
> 
> Just concerned about electrical damage to drive/backplane here.
..

It should be quite safe, so long as software isn't accessing the drive.

-ml
