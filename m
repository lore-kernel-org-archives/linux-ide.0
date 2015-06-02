From: Ian Campbell <ijc@debian.org>
Subject: Re: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
Date: Tue, 02 Jun 2015 08:14:52 +0100
Message-ID: <1433229292.5748.291.camel@debian.org>
References: <1433068534.5748.276.camel@debian.org>
	 <20150601025050.GB11354@lunn.ch> <1433192857.5748.288.camel@debian.org>
	 <20150601210702.GN22739@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from benson.vm.bytemark.co.uk ([212.110.190.137]:56893 "EHLO
	benson.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbbFBHO4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2015 03:14:56 -0400
In-Reply-To: <20150601210702.GN22739@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Mon, 2015-06-01 at 23:07 +0200, Andrew Lunn wrote:
> On Mon, Jun 01, 2015 at 10:07:37PM +0100, Ian Campbell wrote:
> > On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
> > > You might also want to try 
> > > 
> > > http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
> > > 
> > > In particular the first patch.
> > 
> > That did the trick, thanks!
> 
> Great.
> 
> A tested-by: for that patch will help grease the path into the kernel.

I think it's already been applied to Gregory's tree, but I replied with
a T-b anyway.

Thanks again,
Ian.

