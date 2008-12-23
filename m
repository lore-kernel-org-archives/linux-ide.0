From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA / DVD-RW: recovering from write errors without rebooting
Date: Tue, 23 Dec 2008 01:54:46 +0000
Message-ID: <20081223015446.7d95ae5e@lxorguk.ukuu.org.uk>
References: <20081223012619.dj3ssmpbiff6zcvf@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34780 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753994AbYLWBye (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Dec 2008 20:54:34 -0500
In-Reply-To: <20081223012619.dj3ssmpbiff6zcvf@m.safari.iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sami Farin <safari-kernel@safari.iki.fi>
Cc: Linux ide Mailing List <linux-ide@vger.kernel.org>

> 2008-12-23 01:44:55.656349088 <3>[17524.249164] ata4.00: status: { DRDY }
> 2008-12-23 01:44:55.656349714 <6>[17524.249171] ata4: hard resetting link
> 2008-12-23 01:44:55.961280094 <6>[17524.554144] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Some drives seem to get stuck if we reset them and they think they have
data to send us. I've sent Jeff some patches for that for 2.6.29 time.
They may help in your case, they may not but if you'd like to see then
let me know and I'll send you the relevant patch to apply.

Alan
