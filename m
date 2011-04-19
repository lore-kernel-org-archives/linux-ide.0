From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Tue, 19 Apr 2011 08:59:25 -0500
Message-ID: <1303221565.3171.12.camel@mulgrave.site>
References: <1303084704.2583.23.camel@mulgrave.site>
	 <1303142114.7167.6.camel@mulgrave.site> <4DAC63EA.4000707@ru.mvista.com>
	 <201104191120.31061.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41668 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752161Ab1DSN72 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 09:59:28 -0400
In-Reply-To: <201104191120.31061.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

On Tue, 2011-04-19 at 11:20 +0200, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] pata_cmd64x: add enablebits checking
> 
> Fixes IDE -> libata regression.
> 
> IDE's cmd64x host driver has been supporting enablebits checking
> since the initial driver's merge.

Actually, the thread discussing the proposed patches is here:

http://marc.info/?t=130315227100005

I much prefer the dummy interface approach to the prereset one because
it prevents any possible poke at the registers which will crash the box.

James


