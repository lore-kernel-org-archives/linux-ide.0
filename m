From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Recent ipr breakage (ata_do_eh api change)
Date: Fri, 04 May 2007 11:21:57 -0400
Message-ID: <463B4F95.5080307@pobox.com>
References: <463B4DF4.70908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48780 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933084AbXEDPWP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 May 2007 11:22:15 -0400
In-Reply-To: <463B4DF4.70908@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, thlin@linux.vnet.ibm.com

Brian King wrote:
> This looks like a fix for a compile problem with the libata-all
> branch. I did some poking around and it looks like the ata_do_eh
> api change is in Jeff's #all branch, but not in #upstream, so
> I am assuming the ipr patch mentioned above should be reverted
> in mainline for now.


At the moment, there is no #upstream branch.  It's all, um, upstream :)

What you see in #ALL is the combination of #reset-seq and #mv-ahci branches.

	Jeff


