From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Use inline function for eieio
Date: Tue, 10 Jul 2007 17:08:03 +0400
Message-ID: <469384B3.1080502@ru.mvista.com>
References: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13318 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753851AbXGJNGB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 09:06:01 -0400
In-Reply-To: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Kumar Gala wrote:
> Move to using inline function variant of eieio instead of inline assmebly.

> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
