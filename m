From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 8 Apr 2010 19:00:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.1004081858560.21305@uplift.swm.pp.se>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net> <alpine.DEB.1.10.1004081811200.21305@uplift.swm.pp.se> <yq1tyrlx5tr.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:36187 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576Ab0DHRAv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 13:00:51 -0400
In-Reply-To: <yq1tyrlx5tr.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

On Thu, 8 Apr 2010, Martin K. Petersen wrote:

> We still haven't been given a comprehensive explanation.  "It breaks 
> something for someone" doesn't really give us much to work with...

I'd imagine the market for a 4k sector drive which only does 4k sectors on 
the wire, would be very limited considering the amount of driver and OS 
support for this. Otoh a lot of OSes write 8 blocks at the same time 
because they use 4k page sizes so doing 512b sectors on the SATA layer and 
4k when writing to the drive makes a lot of sense.

I don't really see what it is you're looking for when it comes to "more 
information"?

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
