From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH libata/for-3.11-fixes] libata: make it clear that
 sata_inic162x is experimental
Date: Fri, 26 Jul 2013 08:46:23 -0400
Message-ID: <20130726124623.GA3013@htj.dyndns.org>
References: <1372353297.24346.4.camel@phoenix>
 <20130627173142.GM4752@decadent.org.uk>
 <1372375714.330.17.camel@phoenix>
 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
 <1372427725.23094.17.camel@phoenix>
 <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
 <20130701061726.GA10717@mtj.dyndns.org>
 <1372668742.17064.23.camel@phoenix>
 <20130722211307.GA16776@mtj.dyndns.org>
 <1374814640.13555.1.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f170.google.com ([209.85.213.170]:57433 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758811Ab3GZMq2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jul 2013 08:46:28 -0400
Received: by mail-ye0-f170.google.com with SMTP id g12so547660yee.15
        for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2013 05:46:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374814640.13555.1.camel@deadeye.wl.decadent.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Martin Braure de Calignon <braurede@free.fr>, 714295@bugs.debian.org, linux-ide@vger.kernel.org, risc4all@yahoo.com

On Fri, Jul 26, 2013 at 05:57:20AM +0100, Ben Hutchings wrote:
> On Mon, 2013-07-22 at 17:13 -0400, Tejun Heo wrote:
> > Hello, guys.
> > 
> > I've committed the following patch to for-3.11-fixes.  It's
> > unfortunate but I can't see a good way out at this point.  :(
> [...]
> 
> This change is also appropriate for a stable update.

Indeed.  Will forward the patch to Greg.

> I will also remove the driver from Debian packages.

Yeap, please do so.

Thanks!

-- 
tejun
