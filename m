From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_nv: Don't attempt using ADMA for (READ|SET)_MAX
 commands
Date: Fri, 13 Apr 2007 18:19:35 +0100
Message-ID: <20070413181935.6d60f230@the-village.bc.nu>
References: <20070413170831.GC27674@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59230 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753724AbXDMRQz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 13:16:55 -0400
In-Reply-To: <20070413170831.GC27674@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@canonical.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, jgarzik@pobox.com, bcollins@ubuntu.com

On Fri, 13 Apr 2007 13:08:31 -0400
Kyle McMartin <kyle@canonical.com> wrote:

> READ_NATIVE_MAX and SET_MAX were causing timeouts on sata_nv controllers.
> Disabling ADMA helped, but that is quite a large hammer to use. Reverting
> 382a6652e91b34d5480cfc0ed840c196650493d4 also helped, but we might as well
> fix it right, instead of disabling the performance gain on cache flushes
> by using ADMA mode.

Probably not going to make any performance difference to blacklist all
non-data commands or all but a few like cache-flush. 

Alan
