From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 19:37:37 +0000
Message-ID: <20110210193737.6cac043d@lxorguk.ukuu.org.uk>
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
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59638 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750893Ab1BJTdw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:33:52 -0500
In-Reply-To: <4D543A8B.7040504@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, 10 Feb 2011 14:20:43 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:

> On 2/10/2011 7:49 AM, Bartlomiej Zolnierkiewicz wrote:
> > no way for kernel alone to get all different cases right.  The best we
> > can do is export all data points to user-space and let it & user deal
> > with the resulting mess..
> 
> Is it even possible to turn the HPA back on when udev runs dmraid?  I
> suppose that would fix the problems with dmraid.

You still don't get it do you.. the actual HPA is irrelevant to this,
utterly and totally.

Dmraid doesn't care about the HPA, it cares solely about the alleged
geometry of the device. It doesn't matter if the drive is unlocked or
not, it matters what magic number the kernel tells dmraid is the geometry.

Alan
