From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Tue, 17 Jan 2012 12:00:21 -0500
Message-ID: <4F15A925.9080007@garzik.org>
References: <20120109003255.GA6598@havoc.gtf.org> <CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com> <4F12E57E.3090805@garzik.org> <1326676534.13517.3.camel@minggr> <1326691403.13517.21.camel@minggr> <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com> <CA+55aFy+1DWUaOMormPHy7hCJxNfdxmiAnj8W0gqNTbeogNN4w@mail.gmail.com> <CA+55aFxvUvWHbJvconcjPmDhUVcCRGxxA-iD+HEngRSt4iox5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60281 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab2AQRAY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2012 12:00:24 -0500
In-Reply-To: <CA+55aFxvUvWHbJvconcjPmDhUVcCRGxxA-iD+HEngRSt4iox5g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 01/16/2012 02:55 PM, Linus Torvalds wrote:
> so old kernels used to be a tiny bit faster despite not doing that
> async thing (still slower than I'd like: I'd think that we should be
> able to resume devices in less than a second, but I don't know where
> all the time goes)

In libata specifically, we remain peppered liberally with a bunch of 
msleep()'s all over the place, particularly when dealing with SATA phys. 
  10ms here, 20ms there, 200ms in sata_link_resume(), it all adds up 
when you're talking about fast boot.

For most hardware, we can scan ports in parallel, which gets you past 
the biggest annoyances, but not all of them.

	Jeff


