From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH REPOST] libata: lengthen interval between SRST set and
 clear
Date: Thu, 28 Sep 2006 06:00:21 -0400
Message-ID: <451B9D35.6040405@pobox.com>
References: <20060928091334.GM25800@htj.dyndns.org> <451B9B90.5020009@pobox.com> <451B9C91.3030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:22241 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965289AbWI1KA0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 06:00:26 -0400
In-Reply-To: <451B9C91.3030106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: justin@jmicron.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> The problem actually has been spotted on sata_nv.  It is suggested that 
> this is dependent on what type of device is attached to the controller. 
>  This problem seems to be caused if the device is slow to ack the first 
> H2D Register FIS.  So, we really don't know which controllers are 
> affected by this.
> 
> How about doing msleep(1) if it's SATA?


Given the minimal amount of problem reports, I'd rather hold off and 
collect data.  What devices are affected?  Is it complaining because 
it's in the middle of a reset when SRST is received?  Is it just one 
model of one device?  Is this definitely reproducible on all SATA 
controllers?  etc.

Too many unknowns right now...

	Jeff


