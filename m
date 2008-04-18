From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: "ata73" == "sd 72" ?
Date: Fri, 18 Apr 2008 02:22:27 -0400
Message-ID: <48083E23.3040505@pobox.com>
References: <4807EB94.80104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37505 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbYDRGWd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 02:22:33 -0400
In-Reply-To: <4807EB94.80104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> While working on sata_mv today, I noticed something weird in the syslog.
> The messages from libata show "ata73" for the port with my drives (pmp),
> but the messages from SCSI (sd) show "sd 72" for those same drives.
> 
> One would really think that these two numbers should agree,
> not be off by one.  I wonder why they differ (or why they are
> almost the same) ?

Just historical reasons, one counts from zero and the other does not...

	Jeff



