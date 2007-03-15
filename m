From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/13] sl82c105: add ->speedproc support
Date: Thu, 15 Mar 2007 20:40:18 +0300
Message-ID: <45F98502.50509@ru.mvista.com>
References: <45F86058.6090509@ru.mvista.com> <45F956B4.1060309@xandros.com> <20070315173633.GA26160@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26596 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932223AbXCORkd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 13:40:33 -0400
In-Reply-To: <20070315173633.GA26160@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Woody Suwalski <woodys@xandros.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Russell King wrote:

>>> I wonder is there are some W83C554 users anywhere -- that chipset 
>>>also supports UltraDMA...

>>Sergei,

>>ARM Netwinder machines are running hard disk IDE on SL82c105.
>>Could you send me the actual source file to try (or a patch)?

> That's actually a W83C553 which does not support UDMA in any shape or
> form according to the documents.

> I guess it's an enhancement found on W83C554, and in that case any
> attempt to add UDMA support to the SL82C105 driver should be done
> such that these older chipsets continue to work.

    I had no plans of adding it so far since there seemed to be no designs 
using that chip but decided to ask if somebody is interested just in case...

MBR, Sergei
