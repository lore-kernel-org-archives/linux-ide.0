From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv (NOT!)
Date: Thu, 21 Aug 2008 18:05:01 -0400
Message-ID: <48ADE68D.20705@rtr.ca>
References: <48A0C170.2000803@verizon.net> <48A307D3.2000905@rtr.ca> <48ABA997.1050109@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44497 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756733AbYHUWFD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 18:05:03 -0400
In-Reply-To: <48ABA997.1050109@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Gill <smgill75@verizon.net>
Cc: linux-ide@vger.kernel.org

Steven Gill wrote:
..
> I am currently running 2.26.2
> 
> I was able to sucessfully burn a CD when connecting this drive to the 
> ICH9 controller sata port, but could not burn a dual layer dvd (There 
> was a similar reset message)
..

Yeah, it looks to me as if libata still has DVD burner issues.
I used my SATA DVDRW drive to burn a Suse DVD the other day,
and the same drive refused to read the burnt disc without first rebooting.

linux-2.6.25.6

Disc was fine, though.  Single-layer.

Cheers

