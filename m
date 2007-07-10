From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Use inline function for eieio
Date: Tue, 10 Jul 2007 23:58:37 +0200
Message-ID: <200707102358.37236.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net> <469384B3.1080502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:21109 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761131AbXGJWEq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:46 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1016694ika
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:45 -0700 (PDT)
In-Reply-To: <469384B3.1080502@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp


[ added Kou back to cc: ]

On Tuesday 10 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Kumar Gala wrote:
> > Move to using inline function variant of eieio instead of inline assmebly.
> 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

applied

Please use host driver name ("scc_pata" in this case) instead of "ide" in
the patch summary if your changes are limited to a single host driver.

This helps later when going through git logs.

> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

Thanks,
Bart
