From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.23.1 - sata_mv (7042) hang with large file operations
Date: Wed, 14 Nov 2007 12:56:39 -0500
Message-ID: <473B36D7.8000205@rtr.ca>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2475 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXKNR4k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 12:56:40 -0500
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Morrison, Tom wrote:
> All,
> 
> I apologize if this has been discussed - but I haven't been
> able to find exactly what I am looking for in the discussions 
> the last few weeks...
> 
> I am running Linux 2.6.23.1 and have a 7042 SATA driver running
> (that seems to run very well) - it has the fixes talked about
> between Jeff & Olaf (mv_sg_fill changes)....
> 
> The problem comes ONLY when I am doing large file operations 
> (e.g.: just copying a file) to/from the SATA drives behind 
> the subject line 7042....it just hangs after about 10-15 
> seconds into the copy...
> 
> How large a file causes the hang - you ask - well, somewhere 
> between 100Meg & 500Meg...
> 
> In all other respects - this driver seems to be working...
> 
> Is there a known problem - or do I need to describe in more
> detail?
> 
> Thanks in advance for any / all ideas / questions /...etc
..

Can you give me exact details of how to set up and reproduce this?
  -- Kernel version
  -- number/config/model of drives
  -- exact command line sequence to cause the failure

Thanks
