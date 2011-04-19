From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Tue, 19 Apr 2011 13:29:10 +0100
Message-ID: <20110419132910.0c791430@lxorguk.ukuu.org.uk>
References: <1303084704.2583.23.camel@mulgrave.site>
	<1303142114.7167.6.camel@mulgrave.site>
	<4DAC63EA.4000707@ru.mvista.com>
	<201104191120.31061.bzolnier@gmail.com>
	<20110419110838.3deafeff@lxorguk.ukuu.org.uk>
	<BANLkTinCN3_ex1w3vWBbkBLhUx2UW+Xrhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55218 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752028Ab1DSM23 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 08:28:29 -0400
In-Reply-To: <BANLkTinCN3_ex1w3vWBbkBLhUx2UW+Xrhw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

On Tue, 19 Apr 2011 13:50:12 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Tue, Apr 19, 2011 at 12:08 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >> Subject: [PATCH v2] pata_cmd64x: add enablebits checking
> >>
> >> Fixes IDE -> libata regression.
> >
> > And causes a regression too
> 
> Could you be more explicit?
> 
> Regression in this patch would mean that old driver currently doesn't
> work which is not true..

The old driver fails on some of the hot plug boxes because the enable
bits don't seem to be valid. See the rest of the discussion on this thread

Hence the comment I made about needing to also check the parent bridge

Alan
