From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: fix recovery time calculation (take 2)
Date: Fri, 2 Mar 2007 21:34:07 +0100
Message-ID: <200703022134.07371.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702262332.31751.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:44199 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030622AbXCBWUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 17:20:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1443570nfa
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 14:20:07 -0800 (PST)
In-Reply-To: <200702262332.31751.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Monday 26 February 2007, Sergei Shtylyov wrote:
> The driver wrongly takes the address setup time into account when calculating
> the PIO recovery time -- this leads to slight overclocking of the PIO modes 0
> and 1 (so, the prayers failed to help, as usual :-).  Rework the code to be
> calculating recovery clock count as a difference between the total cycle count
> and the active count (we don't need to calculate the recovery time itself since
> it's not specified for the PIO modes 0 to 2, and for modes 3 and 4 this formula
> gives enough recovery time anyway in the chip's supported PCI frequency range).
> 
> This patch has been inspired by reading the datasheets and looking at what the
> libata driver does; it has been compile-tested only (as usual :-) but anyway,
> the new code gives the same or longer recovery times than the old one...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> ---
> Just discovered a missed rename in this patch -- it's always a good idea to
> enable a debugging option when compiling. :-)
> The later patches should be still applying without issues...

I replaced the old patch with this one, thanks
