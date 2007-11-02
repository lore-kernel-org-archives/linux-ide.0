From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] pata_amd: fix and improve cable detection
Date: Fri, 2 Nov 2007 15:44:06 +0000
Message-ID: <20071102154406.7596b384@the-village.bc.nu>
References: <472B402A.4030009@gmail.com>
	<472B4078.90009@gmail.com>
	<472B40B0.6010702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35977 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755760AbXKBPmw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 11:42:52 -0400
In-Reply-To: <472B40B0.6010702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, 03 Nov 2007 00:22:24 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Cable detection on Nvidia PATA hosts is pathetic.  The current
> nv_cable_detect() assumes that the native cable detection only
> mistakes 80c as 40c but this isn't true.  On ASUS A8N-E, cable
> register almost always says 80c is attached and it also manages to
> trick the drive that the cable is 80c.

According to the last Nvidia comments on Nvidia there is no cable detect
bit. I've just never gotten around to implementing it because due to lack
of documentation Nvidia PATA is very very low priority compared to
problems with documented chipsets from helpful vendors.

Alan
