From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 30 Jan 2007 19:54:20 -0500
Message-ID: <45BFE8BC.3000906@pobox.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52191 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbXAaAy1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 19:54:27 -0500
In-Reply-To: <20070130233735.GA7483@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, konradr@us.ibm.com

Gary Hade wrote:
> Some of my random thoughts:
> There does appear to be this invalid assumption that 0xFF status 
> always implies device-not-present.  The status register access 
> restrictions in ATA/ATAPI-7 V1 5.14.2 include the statement "The 
> contents of this register, except for BSY, shall be ignored when 
> BSY is set to one." which the code does not honor.  There is apparently 
> past experience that 0xFF status implies device-not-present for some
> controllers (the odd clowns :) but I have no idea how common these are.
> We obviously can't get rid of the check but since we cannot clear
> the read-only status register and there appears to be no specification 
> dictated upper limit on how long it should take for a software reset to 
> complete it just seems like we need to wait long enough to support the 
> slowest known device which may be the GoVault.


SRST is specified to take no longer than 31 seconds from the clearing to 
the SRST bit to the clearing of the BSY bit.

Look through the software reset protocol documentation (ATA/ATAPI-7 
volume 2), mainly the device state machines.

	Jeff


