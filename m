From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: allow ide-generic users to ask it to capture unknown devices
Date: Sat, 6 Nov 2004 01:46:05 +0100
Message-ID: <200411060146.05980.bzolnier@elka.pw.edu.pl>
References: <1099671737.5556.32.camel@localhost.localdomain> <200411052256.27303.bzolnier@elka.pw.edu.pl> <1099697274.5567.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:24806 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261209AbUKFAna (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:43:30 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42933 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S9749AbUKFAn3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 01:43:29 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:65179 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S100994AbUKFAlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 6 Nov 2004 01:41:32 +0100
In-Reply-To: <1099697274.5567.76.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Saturday 06 November 2004 00:27, Alan Cox wrote:
> On Gwe, 2004-11-05 at 21:56, Bartlomiej Zolnierkiewicz wrote:
> > Why can't generic entry be just added at id 14 in generic_chipsets table?
> 
> Because when someone adds an entry they'll break the driver.

Please be specific, what will break?
 
> > What is the exact purpose of this patch?
> > 
> > AFAICS this option allows users to use generic code for unknown/unsupported
> > devices which can result in unpredictable results (hangs, data corruptions).
> 
> Correct but they must force it on by hand. It generates a printk to tell
> the user and so its obvious in any bug reports..

99% of IDE bugreports don't contain full dmesg...
