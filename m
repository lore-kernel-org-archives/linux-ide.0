From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pata_amd: add support for CS5535 controllers
Date: Fri, 3 Jul 2009 16:21:52 +0100
Message-ID: <20090703162152.5646a496@lxorguk.ukuu.org.uk>
References: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
	<1246630963-5831-2-git-send-email-otavio@ossystems.com.br>
	<20090703153110.3fa5dfbd@lxorguk.ukuu.org.uk>
	<be7a9f3d0907030733w460e63b1o5c48206ebb7e574e@mail.gmail.com>
	<20090703154849.23b62fe3@lxorguk.ukuu.org.uk>
	<be7a9f3d0907030806k140093aav6a30a4d1c41c4aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45464 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752755AbZGCPUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 11:20:22 -0400
In-Reply-To: <be7a9f3d0907030806k140093aav6a30a4d1c41c4aa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Otavio Salvador <otavio@ossystems.com.br>, Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-ide@vger.kernel.org

On Fri, 3 Jul 2009 12:06:05 -0300
Otavio Salvador <otavio@ossystems.com.br> wrote:

> Hello Alan,
> 
> On Fri, Jul 3, 2009 at 11:48 AM, Alan Cox<alan@lxorguk.ukuu.org.uk> wrote:
> > Are they full compatible in the AMD case - I know they are not in the NS
> > case.
> 
> >From what I could see in  the code they are. I've tested in few
> machines here without any problem.

I'd prefer to see documentation to that effect. Adding one of the Geode
guys to the Cc: list to clarify the situation.

Alan
