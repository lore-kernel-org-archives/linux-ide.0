From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/4] ide: fix sparse warning about shadowing 'flags' symbol
Date: Mon, 18 Feb 2008 18:48:51 +0300
Message-ID: <47B9A8E3.7050009@ru.mvista.com>
References: <200802172052.10691.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54096 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752629AbYBRPrt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 10:47:49 -0500
In-Reply-To: <200802172052.10691.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> drivers/ide/ide.c:801:18: warning: symbol 'flags' shadows an earlier one
> drivers/ide/ide.c:732:16: originally declared here

> Also fix some whitespace damage while at it.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

