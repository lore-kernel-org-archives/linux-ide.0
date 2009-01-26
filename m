From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 21:11:33 +0300
Message-ID: <497DFCD5.8040708@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<20090125105045.65021406@lxorguk.ukuu.org.uk>	<497DA356.2090206@ru.mvista.com> <20090126120107.20345a75@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2787 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753949AbZAZSLD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 13:11:03 -0500
In-Reply-To: <20090126120107.20345a75@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>why we have to check for ATA revision prior to that -- unless we're 
>>trying to guard against pre ATA-3 values other than 0 or 0xFFFF.

> Which we are.

    On what grounds? Note that ATA-3 only names 0 and 0xFFFF as inappropriate 
values.

> At the point we first use this function we are poking
> blindly at a device we have not done any other analysis of.

    Do you mean ata_dev_readid()? I'm seeing no issue with checking for ATA 
version there directly if you insist it should be done.

> Alan

MBR, Sergei
