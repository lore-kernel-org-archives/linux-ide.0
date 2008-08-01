From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Fri, 1 Aug 2008 23:34:59 +0100
Message-ID: <20080801233459.11e9b254@lxorguk.ukuu.org.uk>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.10413.stgit@denkblock.local>
	<4892B8FE.1070400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58489 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751319AbYHAWwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 18:52:51 -0400
In-Reply-To: <4892B8FE.1070400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> However, SATA or not, there simply isn't a way to abort commands in ATA.
>  Issuing random command while other commands are in progress simply is
> state machine violation and there will be many interesting results
> including complete system lockup (ATA controller dying while holding the
> PCI bus).  The only reliable way to abort in-flight commands are by
> issuing hardreset.  However, ATA reset protocol is not designed for
> quick recovery.  The machine is gonna hit the ground hard way before the
> reset protocol is complete.

Actually you cau can issue idle immediate on older ATA devices. I am not
clear if that was stuck back into the current accelerometer friendly
drives or not. Would need to check with IBLenovo

