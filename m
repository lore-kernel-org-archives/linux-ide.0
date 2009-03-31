From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ide: call {in|out}put_data() methods from tf_{read|load}()
 methods (take 3)
Date: Tue, 31 Mar 2009 22:59:17 +0400
Message-ID: <49D26805.9080407@ru.mvista.com>
References: <200903312224.15089.sshtylyov@ru.mvista.com> <200903312032.21513.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25069 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761926AbZCaS6r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Mar 2009 14:58:47 -0400
In-Reply-To: <200903312032.21513.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>Handle IDE_FTFLAG_{IN|OUT}_DATA flags in tf_{read|load}() methods by calling
>>{in|out}put_data() methods to transfer 2 bytes -- this will allow us to move
>>that handling out of those methods altogether...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>Changes since take 2:
>>- removed no longer used mm_{inw|outw}() from ide-h8300.c...

> No... please... just make it an incremental change.

> "take 2" was already applied and I'm pushing it to Linus RIGHT NOW

    OK, I didn't know that.

MBR, Sergei
