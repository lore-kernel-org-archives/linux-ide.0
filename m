From: "Darrick Burch" <darrick@tuffmail.com>
Subject: Re: SB600 in AHCI mode will not run SATA optical drive
Date: Mon, 5 Jan 2009 19:41:17 -0500 (EST)
Message-ID: <19325.72.218.132.189.1231202477.squirrel@webmail.tuffmail.net>
References: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net>
    <4961A39C.30405@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxout-03.mxes.net ([216.86.168.178]:3066 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZAFAlU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 19:41:20 -0500
In-Reply-To: <4961A39C.30405@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:

> Could be some kind of SATA PHY quirk or incompatibility that only shows
> up in AHCI mode or something. It seems from the output that the SATA
> link may be going up and down. You could try forcing 1.5Gbps
> (libata.force=1.5Gbps if libata is built in, or force=1.5Gbps when the
> libata module gets loaded) and see if that helps.

That appears to have done it--thanks!  I feel kinda bad now because I was
suspecting a speed issue, but couldn't figure out how to force it.  If I
had read the kernel documentation a little more, I would have found the
kernel option you mentioned.  Duh.  At any rate, thanks again.



