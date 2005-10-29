From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ATAPI error handling work
Date: Sat, 29 Oct 2005 14:33:23 -0400
Message-ID: <4363C073.8020904@pobox.com>
References: <43443CC7.5040706@pobox.com> <20051006053529.GA25976@htj.dyndns.org> <4344F7C0.4030803@pobox.com> <43453B2B.30405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59013 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750991AbVJ2Sd3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 14:33:29 -0400
In-Reply-To: <43453B2B.30405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Douglas Gilbert <dougg@torque.net>

Tejun Heo wrote:
>  As I wrote in the libata EH doc and associated thread, I don't think 
> doing autosensing-by-turning-qc-around is a very good idea.  I hope I 
> can make some point here.

I like autosensing, particularly because we want to get away from using 
a lot of SCSI EH infrastructure, since libata will eventually be 
separated from SCSI.


>  In the other thread, you wrote that the current ATAPI sense requisition 
> is corrupt because it finishes scmd twice and I believe this patch was 
> implemented to fix that.  I disagreed with you in that thread and gave 
> my rationale for that.  If I was wrong in that thread, please ignore 
> what follows.

I correct myself:  the corruption occurs because we obtain the scsi host 
lock (our host_set lock), and then call scsi_finish_command().  This is 
in error, because scsi_finish_command() also acquires the scsi host lock 
via a call to scsi_device_unbusy().

Multiple possible solutions:  separate scsi host lock from our own. 
batching commands until the end of EH, as SCSI EH does.  continue work 
on auto-sensing.  ...

	Jeff


