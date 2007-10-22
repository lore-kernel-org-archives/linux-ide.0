From: Mark Lord <liml@rtr.ca>
Subject: Re: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Mon, 22 Oct 2007 18:36:00 -0400
Message-ID: <471D25D0.9020702@rtr.ca>
References: <471C6C44.2030607@gmail.com> <471CEDD4.5040201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4558 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbXJVWgD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 18:36:03 -0400
In-Reply-To: <471CEDD4.5040201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>

Man.. somebody needs to teach hald the difference between optical drives
and tape drives..   It seems to just sit in a tight loop issuing the same
failed commands over and over and over to the tape unit after boot.

I had to kill it off to gain control of Fedora so I could actually *do*
anything on the system.

Weird.

Any, Albert Lee has claimed the drive.

Cheers
