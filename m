From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata dev_config call order wrong.
Date: Sun, 29 Aug 2004 19:59:55 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1093805994.28289.4.camel@localhost.localdomain>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com>
	 <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com>
	 <41321F7F.7050300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:29569 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268296AbUH2UCC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 16:02:02 -0400
In-Reply-To: <41321F7F.7050300@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sul, 2004-08-29 at 19:25, Jeff Garzik wrote:
> According to the Serial ATA docs, IDENTIFY DEVICE word 93 will be zero 
> if it's Serial ATA.  Who knows if that's true, given the wierd wild 
> world of ATA devices.

You need to check if word 93 is valid first. Same with things like the
cache control word - its value is only meaningful if the drive says the
word is meaningful.

