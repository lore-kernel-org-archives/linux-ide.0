From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: turn selectproc() method into dev_select() method
 (take 5)
Date: Tue, 31 Mar 2009 22:19:32 +0400
Message-ID: <49D25EB4.7060608@ru.mvista.com>
References: <200903251439.54468.sshtylyov@ru.mvista.com> <200903262118.14931.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24518 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754447AbZCaSTG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Mar 2009 14:19:06 -0400
In-Reply-To: <200903262118.14931.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

Bartlomiej Zolnierkiewicz wrote:

>>Turn selectproc() method into dev_select() method by teaching it to write to the
>>device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>Changes since the 4th take:
>>- added ide_dev_select() declaration to <linux/ide.h> at last... :-/

> Seems like putting a bit more time into re-auditing the whole patch after
> first issues are discovered/fixed wouldn't hurt...

    What actually helped was actully compiling the patch. :-)

> and yes, the same can be said about re-reviewing it in this case...

    ;-)

MBR, Sergei
