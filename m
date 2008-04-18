From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: "ata73" == "sd 72" ?
Date: Fri, 18 Apr 2008 10:13:25 +0200
Message-ID: <18440.22565.901222.300756@alkaid.it.uu.se>
References: <4807EB94.80104@rtr.ca>
	<48083E23.3040505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:36993 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbYDRINl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Apr 2008 04:13:41 -0400
In-Reply-To: <48083E23.3040505@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik writes:
 > Mark Lord wrote:
 > > While working on sata_mv today, I noticed something weird in the syslog.
 > > The messages from libata show "ata73" for the port with my drives (pmp),
 > > but the messages from SCSI (sd) show "sd 72" for those same drives.
 > > 
 > > One would really think that these two numbers should agree,
 > > not be off by one.  I wonder why they differ (or why they are
 > > almost the same) ?
 > 
 > Just historical reasons, one counts from zero and the other does not...

Could this possibly be changed, please? I've noticed this
discrepancy myself and it really is confusing.

Maybe the mapping exists in sysfs, but navigating sysfs is
an absolute nightmare IMO so I wouldn't know how to find it.

/Mikael
