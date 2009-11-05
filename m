From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Thu, 5 Nov 2009 16:54:27 +0100
Message-ID: <200911051654.27880.bzolnier@gmail.com>
References: <bug-14310-11633@http.bugzilla.kernel.org/> <200910270835.n9R8ZRB2007651@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:47980 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbZKEP4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Nov 2009 10:56:16 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2468845fga.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Nov 2009 07:56:21 -0800 (PST)
In-Reply-To: <200910270835.n9R8ZRB2007651@demeter.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Tuesday 27 October 2009 09:35:27 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14310
> 
> 
> 
> 
> 
> --- Comment #6 from Jiri Bohac <jbohac@jikos.cz>  2009-10-27 08:35:25 ---
> (In reply to comment #5)
> > Jiri, please try the patch from
> > 
> > http://bugzilla.kernel.org/attachment.cgi?id=23513
> 
> Great, this patch, applied on 2.6.31.5, fixes the problem for me.
> 
> Out of curiosity, I also tried to revert the original fix
> (e13ee546bb06453939014c7b854e77fb643fd6f1) and, with the debug patch still
> applied, it still worked.

Thanks for checking this.

> So maybe 6029336426a2b43e4bc6f4a84be8789a047d139e causes two independent
> problems in sis5513? One fixed with e13ee546bb06453939014c7b854e77fb643fd6f1
> and one fixed with this debug patch?

Yes, your findings are correct.

> It would be great if this patch could be added to the stable tree. Thanks!

The problem is that the change in the debug patch affects all host drivers
and at this moment is not safe enough neither for -stable nor for -rc.

Somebody needs to go and review all host drivers and their usage of ->media
field for tuning logic present in ->set_pio_mode implementations first.

Before this happens we probably should revert commit 6029336 but I'll leave
this up to the maintainer (I seriously doubt he will ever go and review any
IDE drivers or make any IDE fixes so please just ping him about the revert).

Thanks,
-- 
Bartlomiej Zolnierkiewicz
