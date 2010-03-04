From: Florian Zumbiehl <florz@florz.de>
Subject: Re: DMA timeouts with JM20330 based SATA<->IDE bridge
Date: Thu, 4 Mar 2010 22:42:03 +0100
Message-ID: <20100304214203.GA3353@florz.florz.dyndns.org>
References: <20100304014558.GA8837@florz.florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rain.florz.de ([62.216.164.86]:43004 "EHLO
	rain.florz.dyndns.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754912Ab0CDVmH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 16:42:07 -0500
Received: from florz.florz.dyndns.org ([192.168.0.121])
	by rain.florz.dyndns.org with esmtp (Exim 4.69)
	(envelope-from <florz@florz.de>)
	id 1NnInz-0002Qd-JA
	for linux-ide@vger.kernel.org; Thu, 04 Mar 2010 22:42:03 +0100
Received: from florz by florz.florz.dyndns.org with local (Exim 4.69)
	(envelope-from <florz@florz.de>)
	id 1NnInz-0000w4-CC
	for linux-ide@vger.kernel.org; Thu, 04 Mar 2010 22:42:03 +0100
Content-Disposition: inline
In-Reply-To: <20100304014558.GA8837@florz.florz.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

> Now, reading from the disk seems to work perfectly, but writing
> (dding /dev/zero to the block device) causes DMA timeouts every
> few hundred megabytes - in between the timeouts, though,
> throughput seems to be ok (~ 20 MB/s).
> 
> Once the fallback mechanism has switched back to PIO4, things seem
> to work perfectly, albeit slowly :-)

FYI: I just tried forcing the device to MWDMA2, and that seems to work
well, too - wrote some 10 GB without any errors.

Any hints as to how to further debug this would be appreciated.

Florian
