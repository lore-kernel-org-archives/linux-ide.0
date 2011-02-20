From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 12/20] pata_rdc: parallel scanning needs an extra locking
Date: Sun, 20 Feb 2011 18:04:10 +0300
Message-ID: <4D612D6A.3010905@ru.mvista.com>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site> <20110208122502.19110.28978.sendpatchset@linux-mhg7.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f180.google.com ([209.85.215.180]:58801 "EHLO
	mail-ey0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab1BTPF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2011 10:05:29 -0500
In-Reply-To: <20110208122502.19110.28978.sendpatchset@linux-mhg7.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 08-02-2011 15:25, Bartlomiej Zolnierkiewicz wrote:

>  From 540001238b8ebbc4bedd46ca4e2672fcf3787998 Mon Sep 17 00:00:00 2001
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Date: Tue, 8 Feb 2011 12:39:27 +0100
> Subject: [PATCH 12/20] pata_rdc: parallel scanning needs an extra locking

> This is similar change as commit 60c3be3 for ata_piix host driver.

    Linus asks to also specify the commit summary in parens.

> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>

WBR, Sergei
