From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 19:36:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411FF37E.7070001@pobox.com>
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25741 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267249AbUHOXgp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 19:36:45 -0400
In-Reply-To: <411FF170.9070700@rtr.ca>
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> hdparm works for some SCSI devices already, and support for
> more is already on the way.  I imagine I can have it handle
> whatever new ioctls() are being provided from libata as well.
> 
> Care to point me at them?


No new ioctls :)  Say no to ioctls :)

libata _may_ support HDIO_DRIVE_CMD, but more likely will support 
http://www.t10.org/ftp/t10/document.04/04-262r1.pdf

and simply use existing interfaces.

	Jeff


