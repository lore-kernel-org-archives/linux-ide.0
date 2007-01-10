From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: hwif->rw_disk() method
Date: Wed, 10 Jan 2007 22:47:09 +0100
Message-ID: <58cb370e0701101347x38f67e54x32da2ec8262ec7b7@mail.gmail.com>
References: <45A514AB.2080605@ru.mvista.com>
	 <20070110171015.5320fa17@localhost.localdomain>
	 <45A51CEA.9040608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:15338 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965122AbXAJVrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 16:47:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so656481nfa
        for <linux-ide@vger.kernel.org>; Wed, 10 Jan 2007 13:47:09 -0800 (PST)
In-Reply-To: <45A51CEA.9040608@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

On 1/10/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.

Hi,

> Alan wrote:
>
> >>    Alan/Bart/anybody, could you enlighten me why hwif->rw_disk() method came
> >>into being at all?
>
> > When you needed to wrap entire disk operations. The ->dma_ methods only
> > wrap DMA commands.

Exactly.  IIRC ->rw_disk method was used for PIO by (removed) pdc4030 driver.

>     Yeah, good point. But it's not likely that the HighPoint driver actually
> needs this wrapper for PIO or even MW DMA commands...
>
> > For the current support hardware it can probably go, no idea if anyone
> > embedded uses it any more and can't be bothered to check 8)
>
>     Nobody does, as far I can see, except this wretched driver... :-)

Yes, so if HPT hardware doesn't need clock switch for PIO ->rw_disk can go.

Bart
