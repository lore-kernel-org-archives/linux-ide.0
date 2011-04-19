From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Tue, 19 Apr 2011 11:08:38 +0100
Message-ID: <20110419110838.3deafeff@lxorguk.ukuu.org.uk>
References: <1303084704.2583.23.camel@mulgrave.site>
	<1303142114.7167.6.camel@mulgrave.site>
	<4DAC63EA.4000707@ru.mvista.com>
	<201104191120.31061.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52241 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754594Ab1DSKHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 06:07:53 -0400
In-Reply-To: <201104191120.31061.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] pata_cmd64x: add enablebits checking
> 
> Fixes IDE -> libata regression.

And causes a regression too

With the check for parent bridge not being a split bridge I think however
it'll do the job nicely.

Alan
