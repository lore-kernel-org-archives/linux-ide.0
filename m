From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: call udma_filter() before resorting to the UltraDMA mask
Date: Mon, 17 Sep 2007 12:33:16 +0200
Message-ID: <200709171233.16588.bzolnier@gmail.com>
References: <200709152042.37892.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:27223 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXIQLHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 07:07:00 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1117545nfb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 04:06:59 -0700 (PDT)
In-Reply-To: <200709152042.37892.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 15 September 2007, Sergei Shtylyov wrote:
> Give the udma_filter() method call taking precedence over using the mode masks.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied with s/taking//

> ---
> Posting this change separately as have been asked.  Should apply to the current
> Linus' tree...

thanks
