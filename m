From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] opti621: remove DMA support
Date: Thu, 12 Jun 2008 02:10:43 +0400
Message-ID: <48504D63.3030207@ru.mvista.com>
References: <200806112158.18354.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63901 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750782AbYFKWKt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jun 2008 18:10:49 -0400
In-Reply-To: <200806112158.18354.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Juergen Kosel <juergen.kosel@gmx.de>

Hello.

Bartlomiej Zolnierkiewicz wrote:
> These controllers don't support DMA.
>
> Based on a bugreport from Juergen Kosel & inspired by pata_opti.c code.
>
> Tested-by: Juergen Kosel <juergen.kosel@gmx.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
>   

   Verily. I have the 82C621A datasheet.

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


