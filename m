From: Martin Lottermoser <Martin.Lottermoser@t-online.de>
Subject: Re: PATA DMA problem leading to kernel panic on reading movie DVDs
Date: Mon, 18 May 2009 18:40:35 +0200
Message-ID: <20090518164034.GA7789@wanza.invalid>
References: <20090517091224.GA8280@wanza.invalid> <4A10509C.603@gmail.com> <200905172135.10136.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout06.t-online.de ([194.25.134.19]:41398 "EHLO
	mailout06.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbZERQlQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 12:41:16 -0400
Content-Disposition: inline
In-Reply-To: <200905172135.10136.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On Sun, May 17, 2009 at 09:35:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
> * try 2.6.30-rc6 (maybe 2.6.29.3 oops has been fixed already and we just
>   need to backport it)

I've done that and put the resulting files again on the web at:

  http://home.vrweb.de/martin.lottermoser/linux/

The files are named "2.6.30-rc6-*".

The basic result is that the kernel still panics, still in
drivers/ide/ide-io.c, the final output on the real console shows only
a call stack (far deeper than with 2.6.29.3) but no terminating panic
message, and the ouput sent through netconsole arrives truncated.

Regards,
Martin Lottermoser
--
Martin Lottermoser             Martin.Lottermoser at _REMOVE_t-online.de
Greifswaldstrasse 28
38124 Braunschweig             http://home.vrweb.de/martin.lottermoser
Germany
