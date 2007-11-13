From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Tue, 13 Nov 2007 18:08:04 +0800
Message-ID: <47397784.9070205@tw.ibm.com>
References: <471C6C44.2030607@gmail.com> <471CEDD4.5040201@garzik.org> <471D25D0.9020702@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:49439 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXKMKIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 05:08:14 -0500
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lADA8DnO006773
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 05:08:13 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lADA8DJ6119724
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 03:08:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lADA8CWd029557
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 03:08:13 -0700
In-Reply-To: <471D25D0.9020702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Man.. somebody needs to teach hald the difference between optical drives
> and tape drives..   It seems to just sit in a tight loop issuing the same
> failed commands over and over and over to the tape unit after boot.
> 
> I had to kill it off to gain control of Fedora so I could actually *do*
> anything on the system.
> 
> Weird.
> 
> Any, Albert Lee has claimed the drive.
> 

Thanks for the drive.

After playing with the drive and checking the log, the DRQ+ERR problem only
happens when the tape drive is doing REQUEST SENSE. Also the DRQ=1 ERR=1
situation only happens when the tape drive wants us to transfer the CDB,
not the data.

It looks like the ERR=1 here is the residue of the previous command/error:
After an error and receiving the next PACKET command, the drive actually
wants the host to transfer the CDB of the next command (i.e. request sense)
by setting DRQ=1, but somehow it forgets to clear ERR to 0...

Maybe we can ignore the ERR bit if the command is REQUEST SENSE. Patch
to follow.
--
albert

