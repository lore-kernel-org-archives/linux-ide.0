From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: how to enable write back cache on SATA drive?
Date: Fri, 03 Sep 2004 07:50:09 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41385A71.5090600@pobox.com>
References: <ch39av$75s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269631AbUICLuV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Sep 2004 07:50:21 -0400
In-Reply-To: <ch39av$75s$1@sea.gmane.org>
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

Brett Russ wrote:
> A coworker is trying to get this done to no avail.  He's tried hdparm, 
> blktool, sginfo, and scsiinfo without luck--drives appear in write 
> through cache mode and performance testing confirms.  I've not been 
> directly involved but need to see progress.  I had the most hope for 
> blktool but that failed with "BLKFLSBUF: Operation not supported"
> 
> Devices are Maxtor 250G connected to ICH6R in Enhanced non-AHCI mode 
> using Garzik's 2.6.8.1 libata bk kernel tree (last sync'd ~20040820).
> 
> See results of some commands below...all snippets from emails to me.


At present, you cannot turn on wcache, if your drives boot up with 
wcache off.  When SMART support is added, the ability to turn this 
on/off will be added at the same time.

	Jeff


