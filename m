From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
Date: Mon, 1 Jun 2015 23:07:02 +0200
Message-ID: <20150601210702.GN22739@lunn.ch>
References: <1433068534.5748.276.camel@debian.org>
 <20150601025050.GB11354@lunn.ch>
 <1433192857.5748.288.camel@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49515 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911AbbFAVMf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jun 2015 17:12:35 -0400
Content-Disposition: inline
In-Reply-To: <1433192857.5748.288.camel@debian.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ian Campbell <ijc@debian.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Mon, Jun 01, 2015 at 10:07:37PM +0100, Ian Campbell wrote:
> On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
> > You might also want to try 
> > 
> > http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
> > 
> > In particular the first patch.
> 
> That did the trick, thanks!

Great.

A tested-by: for that patch will help grease the path into the kernel.

Thanks
	Andrew
