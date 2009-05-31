From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.20) pata_oldpiix: fix PIO2 underclocking
Date: Sun, 31 May 2009 17:25:14 +0400
Message-ID: <4A22853A.2050600@ru.mvista.com>
References: <200702051945.38972.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26866 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753900AbZEaNZR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 31 May 2009 09:25:17 -0400
In-Reply-To: <200702051945.38972.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello, I wrote:

> Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
> fast timing bank starting with PIO2, just like the ata_piix driver does.
> Also, fix/rephrase some comments while at it.
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

   Hm, looks like pata_efar still needs the same fix...

MBR, Sergei


