From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 22:25:04 +0300
Message-ID: <497E0E10.6090908@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<20090125105045.65021406@lxorguk.ukuu.org.uk>	<497DA356.2090206@ru.mvista.com>	<20090126120107.20345a75@lxorguk.ukuu.org.uk>	<497DFCD5.8040708@ru.mvista.com> <20090126190114.586879f5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3777 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751856AbZAZTYe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 14:24:34 -0500
In-Reply-To: <20090126190114.586879f5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>>>why we have to check for ATA revision prior to that -- unless we're 
>>>>trying to guard against pre ATA-3 values other than 0 or 0xFFFF.

>>>Which we are.

>>    On what grounds? Note that ATA-3 only names 0 and 0xFFFF as inappropriate 
>>values.

> On the grounds that there are devices that predate ATA-3 and that we
> should be robust.

    ATA/PI-4 states they had 0 or 0xFFFF there. Again, we weren't robust (by 
your definition) in other cases of using words 82-83 -- have it caused issues?
    Another argument about robustness: CF specifies word 80 as *reserved* but 
does specifies words 82-84 since at least 2.1. What to do about that?

MBR, Sergei
