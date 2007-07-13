From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Fri, 13 Jul 2007 15:07:39 +0100
Message-ID: <20070713150739.6035c2dd@the-village.bc.nu>
References: <20070709143841.133abb71@the-village.bc.nu>
	<4696965E.70403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43724 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759210AbXGMOBU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 10:01:20 -0400
In-Reply-To: <4696965E.70403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

> Since we're guessing (I assume?), I definitely want to make sure we have 
> the correct MV variant for use with RocketRAID.

We are not guessing. There is sufficient information in the driver to
identify the specific chip variant
