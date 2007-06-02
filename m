From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: HPT374 IDE problem with 2.6.21.* kernels
Date: Sun, 3 Jun 2007 01:38:15 +0200
Message-ID: <200706030138.15353.bzolnier@gmail.com>
References: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu> <46608EFE.1030202@ru.mvista.com> <Pine.LNX.4.62.0706020035200.19399@petra.hos.u-szeged.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:13836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762266AbXFBXY0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jun 2007 19:24:26 -0400
Received: by ug-out-1314.google.com with SMTP id j3so476014ugf
        for <linux-ide@vger.kernel.org>; Sat, 02 Jun 2007 16:24:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0706020035200.19399@petra.hos.u-szeged.hu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Saturday 02 June 2007, Geller Sandor wrote:
> On Sat, 2 Jun 2007, Sergei Shtylyov wrote:
> 
> >> The log of a typical IDE reset is available here:
> >
> >> http://petra.hos.u-szeged.hu/~wildy/syslog.gz
> >
> >> This was the worst case: the IDE bus was resetted during the system boot.
> >
> >   Could you try setting HPT374_ALLOW_ATA133_6 to 0 in 
> > drivers/ide/pci/hpt366.c and rebuild/reboot the kernel?
> 
> 
> Hi Sergei,
> 
> This looks promising. Using a vanilla 2.6.22-rc3 I was able to reproduce 
> the problem within a few seconds. With the above modification the machine 
> is running under heavy disk I/O without problems since 30 minutes...

Did it fix the problem for good?

Sergei, do we need to disallow UDMA6 completely on HPT734 or
is it only an issue with some problematic devices (=> blacklist)?

Either way we need to fix it somehow for 2.6.22.

Thanks,
Bart
