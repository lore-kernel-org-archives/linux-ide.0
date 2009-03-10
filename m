From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: identify data word 53 bit 1 doesn't cover words
 62 and 63 (take 2)
Date: Tue, 10 Mar 2009 15:52:04 +0300
Message-ID: <49B66274.3050502@ru.mvista.com>
References: <200903031404.45443.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48605 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752294AbZCJMv1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 08:51:27 -0400
In-Reply-To: <200903031404.45443.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> The IDE code assumed for years that the bit 1 of the identify data word 53 also
> covers the validity of the SW/MW DMA information in words 62 and 63, but it has
> always covered only words 64 thru 70, with words 62 and 63 being defined in the
> original ATA spec, not in ATA-2...

> This fix however should only concern *very* old hard disks and rather old CF
> cards...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Looks like the patch is still incomplete, as I've only fixed the generic 
files, while two drivers also needed to be fixed... :-/

WBR, Sergei
