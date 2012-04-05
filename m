From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Thu, 05 Apr 2012 11:07:56 +0200
Message-ID: <4F7D60EC.4050805@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7C64B8.5000909@metasoft.pl> <4F7C65CE.6000309@metasoft.pl> <201204041523.50872.arnd@arndb.de> <4F7D4F21.2060401@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:35111 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab2DEJIU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Apr 2012 05:08:20 -0400
In-Reply-To: <4F7D4F21.2060401@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, H Hartley Sweeten <hartleys@visionengravers.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

On 2012-04-05 09:52, Rafal Prylowski wrote:
> Jiffies seem to work. I was wrong with this interrupt handler. Actually
> IDE register read/write (and IORDY polling) is called from softirq,

Well, you were right... Jiffies doesn't work, I thought it work
because I wrongly selected time_is_before_jiffies instead of
time_is_after_jiffies... I will try to use ktime_get.

Thanks,
RP
