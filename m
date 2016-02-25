From: Tejun Heo <tj@kernel.org>
Subject: Re: rcar_sata DMA warnings on Salvator-X
Date: Thu, 25 Feb 2016 16:42:24 -0500
Message-ID: <CAOS58YMv+vBsCrG3ftJSPAxTXgo9gNmxaVeKv8xfNygJgrmSmA@mail.gmail.com>
References: <CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com>
	<20160225214036.GI6092@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33983 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcBYVmZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 16:42:25 -0500
In-Reply-To: <20160225214036.GI6092@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>

On Thu, Feb 25, 2016 at 4:40 PM, Tejun Heo <tj@kernel.org> wrote:
> Is this the problem fixed by the following patch from Harvey?
>
>  http://lkml.kernel.org/g/CAMuHMdU0=_TJVfy=-zXWHkfJSWH_fJULBrL8J9T60QS48WbYcQ@mail.gmail.com

Oops, I meant

http://lkml.kernel.org/g/1456327003-16295-1-git-send-email-harvey.hunt@imgtec.com

Thanks.

-- 
tejun
