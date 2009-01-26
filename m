From: Felix Miata <mrmazda@ij.net>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Mon, 26 Jan 2009 16:34:53 -0500
Message-ID: <497E2C7D.3090101@ij.net>
References: <20090120002923.065f24ca@diego-desktop> <497E0940.3020409@ij.net> <497E14DD.20506@rtr.ca> <200901261557.42752.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-satin.atl.sa.earthlink.net ([207.69.195.63]:50279 "EHLO
	pop-satin.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752003AbZAZVev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 16:34:51 -0500
Received: from user-142gt2m.cable.mindspring.com ([72.40.116.86] helo=[192.168.0.51])
	by pop-satin.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1LRZ6Y-0002v3-00
	for linux-ide@vger.kernel.org; Mon, 26 Jan 2009 16:34:50 -0500
In-Reply-To: <200901261557.42752.gene.heskett@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2009/01/26 15:57 (GMT-0500) Gene Heskett composed:

> On Monday 26 January 2009, Mark Lord wrote:

>>Under Linux, use this:  hdparm -I /dev/sd? | head -8

Thanks much! :-)

> Should I be worried about this one? Seagate 500GB sata

> /dev/sdb:

> ATA device, with non-removable media
>         Model Number:       ST3500320AS
>         Serial Number:      9QM5BB7Y
>         Firmware Revision:  SD15
>         Transport:          Serial

Based upon
http://seagate.custkb.com/seagate/crm/selfservice/search.jsp?DocId=207951 I
would contact Seagate support ASAP.
-- 
"Train a child in the way he should go, and when he
is old he will not turn from it." Proverbs 22:6 NIV

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/
