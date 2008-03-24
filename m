From: Micael Beronius <micael.beronius@abc.se>
Subject: Re: Marvell 6141 support
Date: Mon, 24 Mar 2008 07:57:41 +0000 (UTC)
Message-ID: <loom.20080324T074551-373@post.gmane.org>
References: <1205578981.3107.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50780 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947AbYCXJPI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Mar 2008 05:15:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Jdili-000605-JF
	for linux-ide@vger.kernel.org; Mon, 24 Mar 2008 09:15:02 +0000
Received: from h-142-3.A213.cust.bahnhof.se ([85.24.142.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 09:15:02 +0000
Received: from micael.beronius by h-142-3.A213.cust.bahnhof.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 09:15:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Andy Sturrock <linux-kernel <at> sturrock.org> writes:

> 
> Hi Jeff,
> 
> The patch you submitted back in May 2007 you called "Add Marvell 6141
> ..

> Initially all seems fine, I can see the attached drives in /dev and
> fdisk and mkfs.ext3 seem to work OK.  
> Then I tried putting the drives into a RAID 5 array using
> mdadm and it all went pear-shaped - see output from dmesg etc attached.


Hi Andy, I am not Jeff, unforturnately... :) But I just wanted to confirm that 
what you have seen is exactly what I learned and posted last summer (2007-08-04 
10:11:48 GMT). At the time, I tried all kernels and branches I could get my 
hands on.

Also I would not mind helping, but similar to you, I have not any knowledge 
about the sata subsystem. But I can certainly test etc.

In order to get into trouble, it seams that exercising more than one disk at 
the same time on the interface "does it". - i.e. one doesn't have to go raid.

Regards,
 Micael


