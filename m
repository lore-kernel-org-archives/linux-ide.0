From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Regression: commit "ide: constify struct ide_port_info" causes
 breakage
Date: Fri, 26 Oct 2007 20:38:15 +0400
Message-ID: <472217F7.6060501@ru.mvista.com>
References: <20071026155648.GB4321@flint.arm.linux.org.uk> <47221164.10200@ru.mvista.com> <alpine.LFD.0.999.0710260929290.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:58856 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752133AbXJZQiI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 12:38:08 -0400
In-Reply-To: <alpine.LFD.0.999.0710260929290.30120@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hello.

Linus Torvalds wrote:

>>   We can just convert cariables declared as 'struct hpt_info' to const too -- 
>>they are read-only templates.

> Generally "__devinitdata" is better than "const", since it means that the 
> data may be thrown away.

    Agreed.

> So if you drop one over the other,

    No, just add 'const' to already __devinitdata data to make gcc happy again.

> it's generally the "const" that should be dropped ;/

    Well, this may break when/if we need to add __devinitdata that is actually 
r/w -- not likely with this driver but still...

> 		Linus

WBR, Sergei
