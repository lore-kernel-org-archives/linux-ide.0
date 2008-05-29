From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] libata-sff: Fix oops reported in kerneloops.org for
 pnp devices with no ctl
Date: Thu, 29 May 2008 22:57:48 +0100
Message-ID: <20080529225748.40f19026@core>
References: <20080529161453.24735.805.stgit@core>
	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>
	<20080529190235.258d304e@core>
	<483EF536.90801@garzik.org>
	<20080529194238.36458a46@core>
	<483F049E.2090809@garzik.org>
	<20080529221058.1169e140@core>
	<20080529223755.12610b87@core>
	<483F26B0.8010006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42358 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759462AbYE2WLv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 18:11:51 -0400
In-Reply-To: <483F26B0.8010006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Honestly I think your first RFC PATCH (dated Thu, 29 May 2008 22:10:58 
> +0100) turned out better than this.
> 
> NO_ALTSTATUS is a bit ugly, don't you think?

I do , but Linus seemed to like it ;)
> 
> In any case, based on a quick review I would certainly ack the first RFC 
> PATCH.

Ok. I'll run a full test set on that one tomorrow
