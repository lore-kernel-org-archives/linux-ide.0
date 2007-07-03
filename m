From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix] hpt366: use correct enablebits for HPT36x
Date: Tue, 3 Jul 2007 21:06:59 +0200
Message-ID: <200707032107.00131.bzolnier@gmail.com>
References: <200706300004.22274.sshtylyov@ru.mvista.com> <20070703162641.GA4302@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:28914 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629AbXGCU0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so170452ugf
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:48 -0700 (PDT)
In-Reply-To: <20070703162641.GA4302@austin.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, michal.kepien@poczta.onet.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 03 July 2007, Linas Vepstas wrote:
> Hi,
> 
> On Sat, Jun 30, 2007 at 12:04:22AM +0400, Sergei Shtylyov wrote:
> > The HPT36x chips finally turned out to have the channel enable bits -- however,
> > badly implemented.  Make use of them despite it's probably only going to burden
> > the driver's code -- assuming both channels are always enabled by the HighPoint
> > BIOS anyway...
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> > ---
> > Michal, Linas, please verify the patch... :-)
> 
> No negative impact for me.
> 
> (Am I supposed to acked-by if I do this kind of review/test?)

added your ACK also for this patch

Bart
