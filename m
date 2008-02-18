From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH ht6560b] Force prefetch for some devices
Date: Mon, 18 Feb 2008 16:58:52 +0300
Message-ID: <47B98F1C.3050808@ru.mvista.com>
References: <47B97EFA.2040805@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:52856 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751232AbYBRN5v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 08:57:51 -0500
In-Reply-To: <47B97EFA.2040805@caiway.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Jan Evert van Grootheest wrote:

> Prefetch needs to be set for some ide devices to work when connected to

    Prefetch bit seems to mean 1=disable, 0=enable despite what the datasheet 
says...

> a ht6560b interface. This was not always done properly, causing a system
> with a HD and CD on the primary interface to not work properly. Or, in
> effect, hang hard.

> This patch forces prefetch on devices before checking whether it
> is necessary to change the settings in the interface

> This patch should also be applied to 2.4. I don't currently have a
> 2.4 tree around.

> (also change my email address)

> Signed-off-by: Jan Evert van Grootheest <janevert@caiway.nl>

    Please send the patch to the current 2.4 maintainer, after applying it to 
the 2.4 tree which you can download on kernel.org.

> ------------------------------------------------------------------------
> 
> --- linux-2.6.git/drivers/ide/legacy/ht6560b.c	2008-02-01 18:50:31.000000000 +0100
> +++ linux-2.6.24/drivers/ide/legacy/ht6560b.c	2008-02-18 13:48:59.000000000 +0100
> @@ -23,18 +23,21 @@
>   *                      "Prefetch" mode bit OFF for ide disks and
>   *                      ON for anything else.
>   *
> + *  Version 0.08        Need to force prefetch for CDs and other non-disk
> + *                      devices. (not sure which devices exactly need
> + *                      prefetch)
>   *

    Hard disks only ai guess, i.e. non-ATAPI device.

MBR, Sergei
