From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Inclusion of patch for Promise SATAII 150 TX4 in mainline 2.6
 kernel?
Date: Mon, 07 Feb 2005 16:39:00 -0500
Message-ID: <4207DFF4.8010208@pobox.com>
References: <Pine.LNX.4.44.0502071601140.31011-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62913 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261333AbVBGVjU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Feb 2005 16:39:20 -0500
In-Reply-To: <Pine.LNX.4.44.0502071601140.31011-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org, Johannes Resch <jr@xor.at>

Mark Hahn wrote:
>>has no builtin support for Promise SATAII 150 TX4 yet; a separate patch 
>>(http://marc.theaimsgroup.com/?l=linux-ide&m=110426005503319&q=raw) is 
>>needed to recognize this hardware.
> 
> 
> I had good luck with this patch as well.  I think the SATA-SMART patches
> should go in too, even if they aren't perfect yet...

The Promise SATAII patch went in today.

The SMART patches absolutely -should not- go in.  Certain common hdparm 
commands can cause data corruption rather than produce expected results.

	Jeff



