From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Fri, 28 Mar 2008 09:48:09 +0000
Message-ID: <20080328094809.63f1de36@core>
References: <12066128663306-git-send-email-htejun@gmail.com>
	<47EBDE84.1070802@emc.com>
	<47EC51C3.1080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45608 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750999AbYC1KGN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 06:06:13 -0400
In-Reply-To: <47EC51C3.1080104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ric@emc.com, jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca

> Yes by reporting the first failing sector.  Probably it's better to test
> failed > last_failed than failed == last_failed.

Flush is not guaranteed to occur in LBA order, so I don't believe "first"
in this case means LBA order first but first block in the write out order
the drive picks.
