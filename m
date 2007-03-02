From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] libata: Cable detection fixes
Date: Thu, 1 Mar 2007 17:24:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703011723270.12485@woody.linux-foundation.org>
References: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:33940 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422679AbXCBBXv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:23:51 -0500
In-Reply-To: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, jgarzik@pobox.com



On Thu, 1 Mar 2007, Alan wrote:
>
> The patch switches the identify order so that we can do the drive side
> detection correctly. 
> 
> Secondly we add a ->cable_detect() method called after the identify
> sequence which allows a host to do host side detection at this point
> should it wish, or to modify the results of the drive side identify.

Alan, sign-offs?

Jeff, should I just expect to get these things through you?

		Linus
