From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] palm_bk3710: add UltraDMA/100 support
Date: Mon, 21 Jul 2008 20:13:48 +0200
Message-ID: <200807212013.49362.bzolnier@gmail.com>
References: <200807171705.00026.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:32676 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbYGUTJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 15:09:29 -0400
Received: by ug-out-1314.google.com with SMTP id h2so296843ugf.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jul 2008 12:09:27 -0700 (PDT)
In-Reply-To: <200807171705.00026.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 17 July 2008, Sergei Shtylyov wrote:
> This controller supports UltraDMA up to mode 5 but it should be clocked with
> at least twice the data strobe frequency, so enable mode 5 for 100+ MHz IDECLK.
> 
> While at it, start passing the correct device to clk_get() -- it worked anyway
> but WTF? :-/
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
