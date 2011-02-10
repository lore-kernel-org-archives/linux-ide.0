From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 19:35:24 +0000
Message-ID: <20110210193524.2d2f60d0@lxorguk.ukuu.org.uk>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
	<4D5306F8.6050106@cfl.rr.com>
	<20110209213904.4aff945d@lxorguk.ukuu.org.uk>
	<4D532FFC.2020503@cfl.rr.com>
	<AANLkTikL6rGvg7PeCzJPAaWm9-4dniCY4NErGUgi_54N@mail.gmail.com>
	<4D543A8B.7040504@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59629 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755139Ab1BJTbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:31:39 -0500
In-Reply-To: <4D543A8B.7040504@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> What worries me though is that while it seems that most systems so far
> do not seem to store anything vital in the HPA so unlocking by default
> does not cause harm, it is defined as a feature, not a bug, so future
> systems can very well start storing vital data there, and then we really
> will step in it by always unlocking.

Lots of systems store lots of things they define as 'essential' in both
HPA and non HPA areas, I've seen uglies like laptops with a 2GB+ HPA
holding the windows reinstall for example.

Strangely enough the users often disagree on the subject, and also the
vendors tend to be sensible about what happens if it isn't there because
users do disk swaps when drives fail or as aftermarket upgrades.

Alan
