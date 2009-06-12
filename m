From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/9] ide: move ack_intr() method into 'struct ide_port_ops'
Date: Fri, 12 Jun 2009 23:24:38 +0400
Message-ID: <4A32AB76.1060408@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102251.16359.sshtylyov@ru.mvista.com> <200906121819.00690.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34101 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753257AbZFLTYm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jun 2009 15:24:42 -0400
In-Reply-To: <200906121819.00690.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>> Move the ack_intr() method into 'struct ide_port_ops', also renaming it to
>> test_irq() while at it...
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>
>> ---
>> The patch is atop of ide-2.6.git 'for-next' branch.
>>
>>  drivers/ide/buddha.c |   27 ++++++++++++++++-----------
>>  drivers/ide/gayle.c  |   14 +++++++++-----
>>  drivers/ide/ide-io.c |    3 ++-
>>  drivers/ide/macide.c |   12 ++++--------
>>  include/linux/ide.h  |   10 +---------
>>  5 files changed, 32 insertions(+), 34 deletions(-)
>>     
>
> Seems to be missing changes to ide-probe.c (!),

   Hm... not sure how I've managed to miss it. :-<

>  falconide.c and q40ide.c.
>   

   Yet I was sure that I'd touched every driver with ack_intr()... :-/
   Working on one patch for several days doesn't help. :-(

WBR, Sergei


