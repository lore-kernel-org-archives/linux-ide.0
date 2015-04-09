From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] ide: replace GFP_ATOMIC by GFP_KERNEL
Date: Thu, 9 Apr 2015 17:40:36 +0300
Message-ID: <20150409144036.GB16501@mwanda>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
 <1428579988-10167-3-git-send-email-lambert.quentin@gmail.com>
 <20150409123633.GN10964@mwanda>
 <55268DCB.3010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24166 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbDIOkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2015 10:40:52 -0400
Content-Disposition: inline
In-Reply-To: <55268DCB.3010201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Apr 09, 2015 at 04:33:47PM +0200, Quentin Lambert wrote:
> 
> 
> On 09/04/2015 14:36, Dan Carpenter wrote:
> >Oh.  They're not GFP_ATOMIC.
> >
> >Fold these two patches together into one patch and resend.
> The reason I did it that way is because I feel that the two patches
> really are different.
> The first one do not change the execution of the code but the second
> one does.
> Could you explain to me why they can be folded into one ?

When I read the first patch it left me with unanswered questions and I
was planning to ask you to redo it.  After you had fixed 1/1 there is no
need for 2/2.

regards,
dan carpenter
