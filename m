From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Date: Sun, 25 Jul 2004 15:00:26 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040725190026.GA30535@kroah.com>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:59111 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264561AbUGYXfm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jul 2004 19:35:42 -0400
Content-Disposition: inline
In-Reply-To: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jul 19, 2004 at 02:47:39PM -0500, Doug Maxey wrote:
> 
> Howdy!
> 
>   This note went out originally to a semi-internal list, but after
>   several comments, posting it here...

Unfortunatly, it seems you didn't listen to those comments :(

>   What I would like is input on the general strategy that should be
>   taken to modify the controller/adapter and device stack to:
> 
>   1) be first class modules, where all controllers/adapters are
>      capable of being loaded and unloaded.  This is directed mostly at
>      IDE/Southbridge controller/adapter devices.
> 
>   2) extend that support to all child devices; disk, optical,
>      and tape.
> 
>   3) be part of mainline.

Great, that all sounds wonderful.

>   The items I perceive at the top of the issue list are:
> 
>   - The primary platforms for IDE/ATA devices are x86 based, and
>     certainly do not care about having this capability.
> 
>   - Assuming the capability is added, what rework would be acceptable
>     for block devices?

Enough to make it work :)

>   - Where should this capability go?  Fork a subset of IDE
>     controllers, and put them under the arch specific dir?
>     Or include all devices?

Not in a arch specific dir please.  You all do that too much as it is...

>   - should we work to the goal of having the capability for all
>     platforms, and all IDE devices?

Yes.

thanks,

greg k-h
