From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Date: Wed, 04 May 2005 16:44:02 +0100
Message-ID: <1115221441.18790.8.camel@localhost.localdomain>
References: <03be01c54e77$83d86980$0f01a8c0@max>
	 <1115056032.10369.33.camel@localhost.localdomain>
	 <033301c54f4e$aedcda80$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:6285 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261871AbVEDPpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2005 11:45:33 -0400
In-Reply-To: <033301c54f4e$aedcda80$0f01a8c0@max>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, Dominik Brodowski <linux@brodo.de>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Llu, 2005-05-02 at 20:39, Richard Purdie wrote:
> We've had this conversation before - I tried the -ac tree and found that 
> whilst it will retry, it blocked whilst waiting and this blocking meant the 
> status of the drive never changed. The "cardctl eject" command would 
> therefore just sit there locked up which didn't really solve my problem.

You have to do that, stick a scope on the port and you'll see that the
IDE layer is still writing to the I/O ports until the last reference is
dropped.

> The changeover to the driver model means all the callbacks.get handled by 
> the kobjects and the function only needs to be called once. I applied that 
> patch and so far it seems to be working very well. As an added bonus, 
> hotunpluging is also working. I can still make it oops but seemingly not in 
> the ide layer any longer (now it looks vfs related :).

It is definitely the right way to go, but you do also have to kill the
IDE ops and know that every current operating reference is no longer
using the old IDE ops before you can safely reuse a PCMCIA port/PCI
slot, otherwise you merely trade easy to find bugs for really nasty
hotplug races.

Alan

