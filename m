From: Andreas Mohr <andi@lisas.de>
Subject: Re: 2.6.28-rc3 libata: still "failed to IDENTIFY" on bootup
Date: Tue, 11 Nov 2008 18:46:34 +0100
Message-ID: <20081111174634.GA11632@rhlx01.hs-esslingen.de>
References: <20081109130231.GA20290@rhlx01.hs-esslingen.de> <4919521E.2040703@kernel.org> <20081111161113.GA4179@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:49720 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbYKKRqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 12:46:36 -0500
Content-Disposition: inline
In-Reply-To: <20081111161113.GA4179@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

On Tue, Nov 11, 2008 at 05:11:13PM +0100, Andreas Mohr wrote:
> But, yeah, it could just be an illegal factory-shipped hardware config, ya know
> (need to investigate actual setup here, maybe it turns out to be
> "combined Master/Slave" jumpering - with one Master drive only...)

OK, I researched this some more.

When booting with the CDRW removed from the slot the IDENTIFY issue
does NOT occur!
This drive (Dell P/N 996NF) does not have any hardware jumper, but
probably is configured via firmware variants (like many notebook drives
seem to be).
Visited BIOS settings, no clues or settings there.
Not the faintest clue as to what the drive is configured as internally,
although many notebook drives seem to be shipped as Cable Select (but definitely
not all!!).


At http://www.clave.gr.jp/ml/bsd-nomads/200011/msg00068.html , it's BSD(!)
which is showing an identify retried exceeded error with the CRX700E !!!!
Note that this seems to be a THINKPAD here, thus the other OEM (IBM) which there
are CRX700E firmware updates available for.


Some remotely useful (added for reference) URLs might be
http://forums.techguy.org/hardware/348262-dell-2nd-hd-media-bay.html
http://www.notebook-doctor.com/it-pi-n-DVD_Writer_for_Dell_Latitude_D510-pId-238000.html
http://www.motherboardpoint.com/t43872-dimension-8200-is-it-cable-select.html
http://www.wer-weiss-was.de/theme21/article4243889.html


Hmm, now if this drive happened to be configured as Cable Select as I'd guess it is:
do we have a problem here?? IOW are we mis-handling non-explicitly configured
(i.e., CSEL) setups?

...but:
when searching for the "identify retried exceeded" BSD error message
the CRX700E-mentioning page is the _only_ one that comes up on Google!!
(IOW, it strongly looks like this issue seems quite isolated to CRX700E drives
only and we should find a way to implement an IDENTIFY-timeout-related blacklist flag,
for CRX700E, somehow).

...right?

(BTW, does a drive firmware have to do something special to obey
Cable Select protocol properly, and would this thus indicate a firmware bug indeed?)

Thanks,

Andreas
