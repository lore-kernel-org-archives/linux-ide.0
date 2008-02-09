From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide/arm/bast-ide.c compile error
Date: Sat, 09 Feb 2008 20:58:23 +0300
Message-ID: <47ADE9BF.7020303@ru.mvista.com>
References: <20080209001515.GF6505@cs181133002.pp.htv.fi> <200802091905.24827.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5296 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751417AbYBIR5b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Feb 2008 12:57:31 -0500
In-Reply-To: <200802091905.24827.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, rmk@arm.linux.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove 'ide_hwif_t **hwif' argument from bastide_register()
> (together with write-only ifs[]).

> Cc: Adrian Bunk <bunk@kernel.org>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
