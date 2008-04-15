From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Pb1200/DBAu1200: IDE resource size off by one
Date: Tue, 15 Apr 2008 16:56:55 +0400
Message-ID: <4804A617.5010703@ru.mvista.com>
References: <200804142107.30799.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10866 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763906AbYDOM5g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 08:57:36 -0400
In-Reply-To: <200804142107.30799.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ralf@linux-mips.org, bzolnier@gmail.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org

Hello, I wrote:

> The IDE platform device on Pb1200/DBAu1200 boards claims one byte too many for
> its memory resource -- fix the platform code and the IDE driver in accordance.

    Don't apply this patch yet. It turned out that the resource size is 
actually twice wrong -- 257 ISO 512. I'll send an updated patch soon.

WBR, Sergei
