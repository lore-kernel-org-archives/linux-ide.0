From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [git patches] libata updates 1 of 3
Date: Sat, 10 Feb 2007 10:20:09 +0000
Message-ID: <1171102809.29713.221.camel@pmac.infradead.org>
References: <20070210010914.GA19717@havoc.gtf.org>
	 <20070210054629.GA4395@gentoox2.trippelsdorf.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:45429 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbXBJKUr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 05:20:47 -0500
In-Reply-To: <20070210054629.GA4395@gentoox2.trippelsdorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sat, 2007-02-10 at 06:46 +0100, Markus Trippelsdorf wrote:
>  sata_via 0000:00:0f.0 : failed to iomap PCI BAR 0

Zero probably isn't allowed any more. We have to use PCI BAR 1 and
upwards only or the poor driver authors will get confused :)

-- 
dwmw2

