From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] ide: replace GFP_ATOMIC by GFP_KERNEL
Date: Thu, 9 Apr 2015 18:13:16 +0300
Message-ID: <20150409151316.GO10964@mwanda>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
 <1428579988-10167-3-git-send-email-lambert.quentin@gmail.com>
 <20150409123633.GN10964@mwanda>
 <55268DCB.3010201@gmail.com>
 <20150409145035.GC16501@mwanda>
 <alpine.DEB.2.10.1504091652420.2598@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40869 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbbDIPNe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2015 11:13:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1504091652420.2598@hadrien>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Quentin Lambert <lambert.quentin@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Apr 09, 2015 at 04:53:48PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 9 Apr 2015, Dan Carpenter wrote:
> 
> > Sorry, my last email was bad.
> >
> > Splitting patches into logical parts is a bit tricky.  Let me try
> > explain better.
> >
> > Every patch should sort of make sense on its own.  In the original code
> > it's using GFP_ATOMIC but that's because the original API was bad and
> > we had no choice.  In the 1/1 patch we're using GFP_ATOMIC explicitly
> > by choice and it's wrong.  In patch 2/2 we fix this problem but we
> > shouldn't introduce bad code even if we fix it in later patches.
> 
> But if Quentin's analysis is wrong, then we have to undo the GFP_KERNEL
> choice, and with only one patch we end up back at the pci API?

We still only have to revert one patch either way.

regards,
dan carpenter

