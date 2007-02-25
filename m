From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: via 6421 PATA support done in a rather cleaner fashion
Date: Sun, 25 Feb 2007 19:16:26 +0000
Message-ID: <20070225191626.5f87277b@lxorguk.ukuu.org.uk>
References: <3A1214D41EC70C469B7A95E05149B3EECBA3@aximx50vsync.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51781 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932574AbXBYSM1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 13:12:27 -0500
In-Reply-To: <3A1214D41EC70C469B7A95E05149B3EECBA3@aximx50vsync.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Graham W. Mitchell" <gmitch@woodlea.com>
Cc: linux-ide@vger.kernel.org

> I have a Maxtor 320GB PATA drive connected to the PATA port of a via
> 6421 based card. I can see a SATA drive if I connect it to the SATA
> ports, but I can't see the PATA one using the unpatched driver.

The current VIA code is in 2.6.20-mm and I think 2.6.21-rc, please give
that a spin as it should work properly.

Alan
