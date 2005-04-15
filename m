From: Joe Harvell <jharvell@dogpad.net>
Subject: Re: [SATA] status reports updated
Date: Fri, 15 Apr 2005 13:19:13 -0500
Message-ID: <1113589153.1013.3.camel@wrc2y0me.us.nortel.com>
References: <42600375.9080108@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55]:7857 "EHLO
	zrtps0kn.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261899AbVDOSTV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Apr 2005 14:19:21 -0400
In-Reply-To: <42600375.9080108@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Jeff:

You need to add a comment about the SATAII TX2/TX4 boards indicating
users have experienced data corruption with the sata_promise driver and
the SATAII TX4 board.

I've posted several emails to linux-ide about this.  Why haven't you
responded?

Promise TX2/TX4
Summary: No TCQ/NCQ. Full SATA control including hotplug and PM on all. 

[snip]

Update 2005/04/15: Support for the NCQ-capable SATAII TX2/TX4 boards was
recently added. NCQ support is waiting on libata core.


On Fri, 2005-04-15 at 13:09, Jeff Garzik wrote:
> My Linux SATA software/hardware status reports have just been updated. 
> To see where libata (SATA) support stands for a particular piece of 
> hardware, or a particular feature, go to
> 
> 	http://linux.yyz.us/sata/
> 
> I've still got several patches from EMC (Brett) and IBM (Albert) to go 
> through, as well as a few scattered ones from random authors.
> 
> I'm still working in BitKeeper for the time being.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Joe Harvell
jharvell@dogpad.net

