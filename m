From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch] libata passthrough - return register data from HDIO_* commands
Date: Fri, 19 Aug 2005 15:19:04 -0400
Message-ID: <20050819191902.GC2736@tuxdriver.com>
References: <42FE2FBA.3000605@dresco.co.uk> <430112F6.3090906@dresco.co.uk> <20050819190625.GB2736@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:43786 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965051AbVHSTTK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Aug 2005 15:19:10 -0400
Content-Disposition: inline
In-Reply-To: <20050819190625.GB2736@tuxdriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, Aug 19, 2005 at 03:06:27PM -0400, John W. Linville wrote:
> On Mon, Aug 15, 2005 at 11:11:02PM +0100, Jon Escombe wrote:
> > 
> > >Here is a first attempt at a patch to return register data from the 
> > >libata passthrough HDIO ioctl handlers, I needed this as the ATA 
> > >'unload immediate' command returns the success in the lbal register. 

> Overall, I like the patch.  I trust your assertion that it actually
> works... :-)
> 
> I have a few comments...

Well, apparently "Jon Escombe <lists@dresco.co.uk>" is not a good
address.  I got a delivery failur notification email from his mail
server.  Hopefully Jon reads the lists... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
