From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Thu, 22 Dec 2016 14:22:56 -0500
Message-ID: <20161222192256.GE31216@htj.duckdns.org>
References: <20161202170705.GB6033@htj.duckdns.org>
 <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org>
 <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org>
 <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org>
 <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
 <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35906 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941094AbcLVTW7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2016 14:22:59 -0500
Received: by mail-yb0-f194.google.com with SMTP id s74so1767932ybi.3
        for <linux-ide@vger.kernel.org>; Thu, 22 Dec 2016 11:22:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

On Thu, Dec 22, 2016 at 01:30:23PM -0500, tedheadster wrote:
> > I think this driver should either not be considered 'platform' or it
> > should make a call to free_irq() on failures.
> >
> 
> The question is: who is responsible to free an irq from a device
> registered using platform_device_register_simple()? Is it the driver
> or the platform code?

Sorry, I wasn't clear.  There's a rudimentary garbage collector devm
which tracks all the resources associated with a device.  The previous
patch that I sent you which created an explict resource group and
released it uses the same mechanism.  When any device gets destroyed,
it should release all associated resources and I was wondering why
that wasn't happening without the explicit group operations.  I'll
write up a debug patch to track down what's going on.

Thanks.

-- 
tejun
