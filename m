From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] pata_pdc202xx_old: implement sff_irq_check() method
Date: Fri, 8 Oct 2010 17:35:27 +0100
Message-ID: <20101008173527.5fd7ef6a@lxorguk.ukuu.org.uk>
References: <201010081857.45919.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39002 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757338Ab0JHQKY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2010 12:10:24 -0400
In-Reply-To: <201010081857.45919.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 8 Oct 2010 18:57:45 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is against the recent Linus' tree.

Same question. I know the old code did all this poking around but with
neither driver does it appear to be necessary  ?

