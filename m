From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for
 HPT36x
Date: Sun, 06 May 2007 00:18:09 +0400
Message-ID: <463CE681.9050000@ru.mvista.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <200705052130.53793.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:21052 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933307AbXEEUQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 May 2007 16:16:34 -0400
In-Reply-To: <200705052130.53793.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: michal.kepien@poczta.onet.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>HPT36x chip don't seem to have the channel enable bits, so prevent the IDE core
>>from checking them...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    I'm getting "403 Forbidden" trying to browse this patch (and 
ide-cs-recognize-2gb-compactflash-from-transcend.patch as well).

MBR, Sergei
