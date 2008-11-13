From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/6] ide: remove chipset type fixup from
 ide_host_register()
Date: Thu, 13 Nov 2008 21:55:27 +0900 (JST)
Message-ID: <20081113.215527.74566391.anemo@mba.ocn.ne.jp>
References: <200811122215.15671.bzolnier@gmail.com>
	<491B5DA4.3020405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:63767 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbYKMMzV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Nov 2008 07:55:21 -0500
In-Reply-To: <491B5DA4.3020405@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Nov 2008 01:50:12 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > * Set chipset type explicitly in tx4938ide and tx4939ide host drivers
> >   (all other host drivers were updated already).
> >
> > * Remove no longer used chipset type fixup from ide_host_register().
...
>    I'm not really sure those are "generic".

Of course those are "generic" as they don't need any special hacks in
ide core :-)

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
