From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 3/5] pata_bk3710: clear status bits of BMISP on chipset
 initialization
Date: Thu, 23 Mar 2017 13:39:28 +0300
Message-ID: <bf129198-f778-61d6-07e5-a96c261b08fb@cogentembedded.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182139epcas5p32d912444c0be8747565a4979f8744572@epcas5p3.samsung.com>
 <1490206862-26065-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34194 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdCWKjz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2017 06:39:55 -0400
Received: by mail-lf0-f46.google.com with SMTP id z15so79859446lfd.1
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2017 03:39:31 -0700 (PDT)
In-Reply-To: <1490206862-26065-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 3/22/2017 9:21 PM, Bartlomiej Zolnierkiewicz wrote:

> Clear IORDYINT, INTRSTAT and DMAERROR bits of BMISP register
> (value '1' needs to be written to the bit to clear it).
>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

