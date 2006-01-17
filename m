From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Tue, 17 Jan 2006 11:22:44 +0100
Message-ID: <200601171122.44639.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <200601161849.59629.pvrusb2@toplitzer.net> <43CCBF25.1050400@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:20630 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S932381AbWAQKWq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 05:22:46 -0500
In-Reply-To: <43CCBF25.1050400@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gentoopower <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org

>
> Well then you probably should check your mail system, since I sent an
> answer directly to:

It was no answer. You suggested that a process like
updatedb was doing IDE-transfers.

I made my tests in single user-mode and
there was no other process like updatedb etc. 
consuming the transfer-rate.

This is highly reproducible. Loading and unloading
ehci-hcd, lirc_dev/lirc_i2c and using burnK7 is
always leading to the same results.

Cheers
helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
