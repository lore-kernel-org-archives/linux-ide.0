From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] avoid releasing twice the same region on ide_release_iomio_dma()
Date: Mon, 24 Jul 2006 17:14:54 -0300
Message-ID: <20060724201454.GB18463@cathedrallabs.org>
References: <20060724193031.GA18463@cathedrallabs.org> <44C5264D.4040609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tinc.cathedrallabs.org ([72.9.252.66]:1720 "EHLO
	tinc.cathedrallabs.org") by vger.kernel.org with ESMTP
	id S1751426AbWGXUPA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 16:15:00 -0400
Content-Disposition: inline
In-Reply-To: <44C5264D.4040609@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Hi Sergei,
>    dma_base2 should go away altogether -- this is the IDE maintainer's 
>    opinion:
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=114345699807546&w=2
> 
>    I have posted this patch doing this back in March:
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=114357441529834&w=2
> 
> and it was in the -mm tree for some months but has been removed recently -- 
> I still need to coordinate it with SGI.
no problem, thanks for pointing this out.

-- 
Aristeu

