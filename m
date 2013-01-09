From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: pata_samsung_cf: Use devm_clk_get()
Date: Wed, 09 Jan 2013 16:13:58 +0400
Message-ID: <50ED5F06.1010304@mvista.com>
References: <002c01cdee07$d1ddacc0$75990640$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:38031 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532Ab3AIMOI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2013 07:14:08 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so1770322lab.10
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2013 04:14:06 -0800 (PST)
In-Reply-To: <002c01cdee07$d1ddacc0$75990640$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello.

On 09-01-2013 5:22, Jingoo Han wrote:

> The devm_ functions allocate memory that is released when a driver
> detaches.

    They don't do only that.

> This patch uses devm_clk_get() for these functions.

    Which doesn't allocate any memory.

> These make the code smaller and a bit simpler.

> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

MBR, Sergei


