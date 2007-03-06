From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 25/30] pata_hpt3x3: clean up by using cable method
Date: Tue, 6 Mar 2007 15:19:59 +0000
Message-ID: <20070306151959.2c30b606@lxorguk.ukuu.org.uk>
References: <200703061038.l26AcAVD019539@shell0.pdx.osdl.net>
	<45ED57BA.4000800@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39199 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965057AbXCFOT3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 09:19:29 -0500
In-Reply-To: <45ED57BA.4000800@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com

> dropped patches 9-25.
> 
> they should all be rolled up into a single "update ->cable_detect hook" 
> patch, as discussed.

Strongly disagree. Each cable detect for a driver is testable alone which
means each one is a git bisect point and you can find which driver has
broken that way.

Alan
