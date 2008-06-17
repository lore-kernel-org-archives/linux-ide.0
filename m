From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement
 ATAPI_HORKAGE_NOPIO and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 11:04:50 +0100
Message-ID: <20080617110450.668f37e2@lxorguk.ukuu.org.uk>
References: <4857313A.1000405@kernel.org>
	<48573174.9050103@kernel.org>
	<20080617094354.338e186b@lxorguk.ukuu.org.uk>
	<48578080.5030605@kernel.org>
	<20080617095439.GA9359@lukeross.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42267 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751443AbYFQKWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 06:22:34 -0400
In-Reply-To: <20080617095439.GA9359@lukeross.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luke Ross <luke@lukeross.name>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Originally the drive was bought for a different PC with a Silicon Image
> 3114 controller. The drive worked fine with this (sata_sil). Then I

Ok that proves the point quite nicely. If there is a problem it is not
the one suggested.

Alan
