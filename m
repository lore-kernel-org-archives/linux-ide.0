From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Tue, 9 Sep 2008 11:58:26 +0100
Message-ID: <20080909115826.7c4f5d3c@lxorguk.ukuu.org.uk>
References: <48C45BEF.5090502@gmail.com>
	<20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
	<48C5BD49.6090204@gmail.com>
	<48C5DE2E.7030304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37846 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751949AbYIIK6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 06:58:48 -0400
In-Reply-To: <48C5DE2E.7030304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Antonio Cardoso Martins <digiplan.pt@gmail.com>, linux-ide@vger.kernel.org

> The chipset does have a few quirks, though, and one of those is an inability
> to cope with scatter/gather segments == 64KBytes -- it misinterprets the 64KB
> length value (0x0000) as zero, rather than 0x10000.  I don't know if current
> code (IDE or libata) is still careful about that or not (?).

Both are covered.
