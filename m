From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] libata-sff: fix 32-bit PIO regression
Date: Mon, 9 Feb 2009 10:22:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0902091016520.14410@blonde.anvils>
References: <200902082253.07438.sshtylyov@ru.mvista.com>
 <Pine.LNX.4.64.0902082108290.18661@blonde.anvils> <498F73A5.2070300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:43634 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbZBIKbc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 05:31:32 -0500
Received: from [172.20.26.18]([172.20.26.18]) (1527 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1LWTHh-0000KOC@megami.veritas.com>
	for <linux-ide@vger.kernel.org>; Mon, 9 Feb 2009 02:22:37 -0800 (PST)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
In-Reply-To: <498F73A5.2070300@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl

On Mon, 9 Feb 2009, Sergei Shtylyov wrote:
> Hugh Dickins wrote:
> 
> > Yes, looks nice, and works for me.  My only criticism would be,
> > minor issue unchanged by your patch, that actually "slop" isn't
> > unlikely enough to deserve an "unlikely" - slop of 1 or 3 is
> > unlikely, but slop of 2 is quite common.
> 
>  Common on what types of ATAPI commands? I can hardly believe that they are
> common on the block I/O...

When I checked (mounting and listing a CD), about 34% of
commands had slop 2.  But you're right, now I try copying
a large file, there's no slop involved in that at all.

Hugh
