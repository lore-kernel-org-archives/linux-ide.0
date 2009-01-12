From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/9] sl82c105: remove dead code
Date: Mon, 12 Jan 2009 18:59:47 +0100
Message-ID: <200901121859.48001.bzolnier@gmail.com>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain> <20090106183526.21193.24866.sendpatchset@localhost.localdomain> <496A613F.5090901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:27784 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZALSGA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 13:06:00 -0500
In-Reply-To: <496A613F.5090901@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev list <Linuxppc-dev@ozlabs.org>

On Sunday 11 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > CONFIG_LOPEC and CONFIG_SANDPOINT config options are gone.
> >   
> 
>   So these are gone with arch/ppc/?

Yep.

>   That's a pity -- MV has spent a lot of efforts on porting the latter 
> to arch/powerpc/ but somehow it haven't got merged upstream. My patches 
> ot this driver were actually due to it being used on Sandpoint. :-)

Heh, and I cleaned ppc IDE hooks just before these platforms were removed
(that's how these ifdefs got into sl82c105.c). :-)

Thanks,
Bart
