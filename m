From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_amd dropping to PIO on resume
Date: Tue, 20 Feb 2007 16:42:50 +0000
Message-ID: <20070220164250.24fad51c@localhost.localdomain>
References: <fa.q7ZuddHInqn2dVlS+EWjXjPvFC8@ifi.uio.no>
	<45D63BCE.2080700@shaw.ca>
	<45D6436C.4060209@garzik.org>
	<20070219220812.11c3baba@localhost.localdomain>
	<45DB137F.1060301@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45128 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965055AbXBTPjS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 10:39:18 -0500
In-Reply-To: <45DB137F.1060301@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> places where the bit must be twiddled.  Its easier to leave the bit in 
> the BIOS-initialized state, and ignore the hardware bit's existence in 
> software, if we know the behavior in the controller is hardwired.  Less 
> room for software bugs that way, IMO.

The AMD docs don't categorically answer that question either way that I
can see. The bit appears to make no difference but.. 

Alan
