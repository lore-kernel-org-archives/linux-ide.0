From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] trm290: do hook dma_host_{on,off} methods
Date: Wed, 26 Dec 2007 22:50:21 +0300
Message-ID: <4772B07D.1030206@ru.mvista.com>
References: <200712262247.23255.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:60304 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751515AbXLZTtx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Dec 2007 14:49:53 -0500
In-Reply-To: <200712262247.23255.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello, I wrote:

> Those two methods were reading/writing TRM-290 config. register; luckily (?)
> the writes only tried to change undefined bits.

    Actually, the writes were falling at the PRD address register. Well, 
nobody noticed anyway... :-)

MBR, Sergei
