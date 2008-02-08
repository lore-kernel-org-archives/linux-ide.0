From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pdc202xx_old: always enable burst mode
Date: Fri, 08 Feb 2008 20:25:35 +0300
Message-ID: <47AC908F.2060201@ru.mvista.com>
References: <200802072214.44352.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:60903 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764340AbYBHRYn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 12:24:43 -0500
In-Reply-To: <200802072214.44352.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bartlomiej Zolnierkiewicz wrote:

> Alan has noticed that distros always enabled burst mode
> (+ datasheet confirms that it is the right thing to do).

> Thus fix pdc202xx_old host driver to do it unconditionally
> and remove no longer needed CONFIG_PDC202XX_BURST option.

> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
