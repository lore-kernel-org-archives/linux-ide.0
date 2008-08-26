From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.27-rc3: IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c
	[ide_core]
Date: Tue, 26 Aug 2008 08:17:52 +0300
Message-ID: <20080826051752.GA4088@deprecation.cyrius.com>
References: <20080820173122.GA7335@deprecation.cyrius.com> <48ADAC7C.7040003@lwfinger.net> <20080825110241.GI2606@deprecation.cyrius.com> <200808252111.22940.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:1989 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbYHZFSE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 01:18:04 -0400
Content-Disposition: inline
In-Reply-To: <200808252111.22940.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> [2008-08-25 21:11]:
> Hmm, I suspect that the root cause of the problem is actually in
> hwif_to_node() assuming that hwif->dev always belongs to a PCI device.
> 
> Does the following patch help?

Yes, that works fine.  Thanks a lot, Bart.

Tested-by: Martin Michlmayr <tbm@cyrius.com>

-- 
Martin Michlmayr
http://www.cyrius.com/
