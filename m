From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend SSD
Date: Thu, 13 Oct 2011 12:35:22 +0200
Message-ID: <201110131235.40956.bzolnier@gmail.com>
References: <20091117.043002.224755438.davem@davemloft.net> <201110121638.09605.bzolnier@gmail.com> <20111012185952.3f36718b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35213 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab1JMKmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 06:42:15 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so1660159gyb.19
        for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2011 03:42:14 -0700 (PDT)
In-Reply-To: <20111012185952.3f36718b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, mpatocka@redhat.com, linux-ide@vger.kernel.org

Alan Cox wrote:

> > > The last state on this I saw it seemd that exactly one person had seen it
> > > on exactly one machine ? Has that changed ?
> > 
> > No, you're right here.
> 
> So as far as is known its a weird glitch on one persons box with one
> device with one firmware that's not been replicated ?
> 
> That's not a patch candidate really is it.

Should we revert following commit then?

commit 10734fc8d5fbf89e88519d72e58cce83be21941a
Author: Alan Cox <alan@linux.intel.com>
Date:   Mon Nov 30 13:22:43 2009 +0000

    pata_via: Blacklist some combinations of Transcend Flash and via
    
    Reported by Mikulas Patocka.
    
    VIA VT82C586B + Transcend TS64GSSD25-M v0826 does not work in UDMA mode
    
    Signed-off-by: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
