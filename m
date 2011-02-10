From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 14:20:43 -0500
Message-ID: <4D543A8B.7040504@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com>	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>	<4D5306F8.6050106@cfl.rr.com>	<20110209213904.4aff945d@lxorguk.ukuu.org.uk>	<4D532FFC.2020503@cfl.rr.com> <AANLkTikL6rGvg7PeCzJPAaWm9-4dniCY4NErGUgi_54N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:62407 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664Ab1BJTUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:20:38 -0500
In-Reply-To: <AANLkTikL6rGvg7PeCzJPAaWm9-4dniCY4NErGUgi_54N@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 7:49 AM, Bartlomiej Zolnierkiewicz wrote:
> no way for kernel alone to get all different cases right.  The best we
> can do is export all data points to user-space and let it & user deal
> with the resulting mess..

Is it even possible to turn the HPA back on when udev runs dmraid?  I
suppose that would fix the problems with dmraid.

What worries me though is that while it seems that most systems so far
do not seem to store anything vital in the HPA so unlocking by default
does not cause harm, it is defined as a feature, not a bug, so future
systems can very well start storing vital data there, and then we really
will step in it by always unlocking.
