From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Fri, 11 Feb 2011 13:22:00 -0500
Message-ID: <4D557E48.3040304@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com>	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>	<4D5306F8.6050106@cfl.rr.com>	<20110209213904.4aff945d@lxorguk.ukuu.org.uk>	<4D532FFC.2020503@cfl.rr.com>	<AANLkTikL6rGvg7PeCzJPAaWm9-4dniCY4NErGUgi_54N@mail.gmail.com>	<4D543A8B.7040504@cfl.rr.com> <20110210193524.2d2f60d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:61262 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969Ab1BKSWH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 13:22:07 -0500
In-Reply-To: <20110210193524.2d2f60d0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 2:35 PM, Alan Cox wrote:
> Lots of systems store lots of things they define as 'essential' in both
> HPA and non HPA areas, I've seen uglies like laptops with a 2GB+ HPA
> holding the windows reinstall for example.
> 
> Strangely enough the users often disagree on the subject, and also the
> vendors tend to be sensible about what happens if it isn't there because
> users do disk swaps when drives fail or as aftermarket upgrades.

That is a very good example of something we should not break without
good cause.  Sure, you might just loose that press key X to recover boot
option, but we still should avoid breaking it.
