From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 04 Aug 2008 23:12:04 +0900
Message-ID: <48970E34.9000706@gmail.com>
References: <87prp1kvyy.fsf@denkblock.local>	<20080726062142.29070.10413.stgit@denkblock.local>	<4892B8FE.1070400@gmail.com> <87proooqry.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:46512 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbYHDOMn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 10:12:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3262202wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Aug 2008 07:12:42 -0700 (PDT)
In-Reply-To: <87proooqry.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
>> For libata, the easiest way to achieve the above would be adding a
>> per-dev EH action, say, ATA_EH_UNLOAD and schedule EH w/ the action OR'd
>> to eh_info->action.  The EH_UNLOAD handler can then issue the command
>> wait for the specified number of seconds and continue.  This will be
>> pretty simple to implement as command exclusion and stuff are all
>> automatically handled by EH framework.
> 
> I'm rather afraid this approach is impractical or unfavourable at the
> very least. Depending on the configured thresholds, a head unload
> request might well be issued unintentionally, e.g. by accidentally
> knocking against the table. It is quite alright for the HD to stop I/O
> for a moment but if the secondary device on the interface happens to be
> a CD writer, it will be very annoying to have CD writing operations fail
> due to minor percussions.

Why would it fail?

> Also, if there are two devices on the same
> port that support the UNLOAD FEATURE and you issue a head unload request
> to both of them in close succession, the IDLE IMMEDIATE to the second
> device will be blocked until the timeout for the first has expired.

Unload can be implemented as port-wide operation so that it issues IDLE
IMMEDIATE to all drives on the port but given that this is mostly for
laptop, this discussion is a bit peripheral.

-- 
tejun
