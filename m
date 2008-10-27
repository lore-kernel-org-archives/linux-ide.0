From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] libata: Drain data on errors
Date: Mon, 27 Oct 2008 21:54:58 +0000
Message-ID: <20081027215458.72c69618@lxorguk.ukuu.org.uk>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180837.7781.26372.stgit@localhost.localdomain>
	<4906132B.1000502@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40598 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751595AbYJ0VzB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 17:55:01 -0400
In-Reply-To: <4906132B.1000502@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

O> I'm just catching up on a few things here now that holiday season is over.
> In the above loop, I wonder if it might be better to only check status
> every NN iterations, where NN > 1 (say, 16), to speed things up a fair amount (?).

And hang some controllers probably.

> Sure it's rare, but when it happens the entire system is probably stopped
> waiting for us to recover, so speed might matter some.

Correctness first. If we have to optimise this case we are (as you note)
doing something seriously wrong!

Alan
