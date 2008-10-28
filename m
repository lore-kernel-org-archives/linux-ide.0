From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] pata_ninja32: suspend/resume support
Date: Tue, 28 Oct 2008 09:37:45 +0000
Message-ID: <20081028093745.0734e0e9@lxorguk.ukuu.org.uk>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180826.7781.59704.stgit@localhost.localdomain>
	<4906981A.2080301@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60864 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753083AbYJ1Jhn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Oct 2008 05:37:43 -0400
In-Reply-To: <4906981A.2080301@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> patches 2-4 look interesting, but I paused to wait for comments (if 
> any).  They look like material for at least a little bit of a linux-next 
> time before going upstream, not really 2.6.28-rc1 [at the time] material 
> IMO...

Agreed except for the DF drain one - that is a bit of harder call. It
seems to be number 1 remaining common across PATA hardware. Can still go
back via -stable after some testing however.

Alan
