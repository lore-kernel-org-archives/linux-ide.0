From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 5 Feb 2007 11:24:10 +0000
Message-ID: <20070205112410.5a3c3182@localhost.localdomain>
References: <20070205075836.GG1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56744 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752507AbXBELLO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 06:11:14 -0500
In-Reply-To: <20070205075836.GG1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

> This patch makes amd74xx not configure udma mode higher than BIOS did.
> If BIOS configured the device <= udma44, udma33 is the maximum speed.

NAK

The boot firmware for AMD/Nvidia chips is only run on PC, and the data is
only valid on some of them, in some cases, and not after a suspend/resume
cycle. You cannot rely on the BIOS (if any) loaded register values. Since
you've posted patches to clean up the drive side detect (when tweaked
with a couple of fixes), this hack won't be neccessary.


