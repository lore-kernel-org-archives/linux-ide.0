From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] speed up SATA
Date: Sat, 27 Mar 2004 19:06:06 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406616EE.80301@pobox.com>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20149 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261979AbUC1AGT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 19:06:19 -0500
In-Reply-To: <406611CA.3050804@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jeff Garzik wrote:
> It's up to the sysadmin to choose a disk scheduling policy they like, 
> which implies that a _scheduler_, not each individual driver, should 
> place policy limitations on max_sectors.


<tangent>

The block layer / scheduler guys should also think about a general (not 
SCSI specific) way to tune TCQ tag depth.  That's IMO another policy 
decision.

I'm about to add a raft of SATA-2 hardware, all of which are queued. 
The standard depth is 32, but one board supports a whopping depth of 256.

Given past discussion on the topic, you probably don't want to queue 256 
requests at a time to hardware :)  But the sysadmin should be allowed 
to, if they wish...

	Jeff



