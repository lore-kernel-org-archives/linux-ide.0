From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Mon, 24 Nov 2008 16:38:52 +0300
Message-ID: <492AAE6C.7000103@ru.mvista.com>
References: <E1L4UpB-0007ro-1g@localhost>	<492A8306.9000400@ru.mvista.com>	<492A9A1F.50401@ru.mvista.com> <20081124123231.555f2395@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:64779 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752208AbYKXNiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 08:38:52 -0500
In-Reply-To: <20081124123231.555f2395@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shane McDonald <mcdonald.shane@gmail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>>  It's 240, not 242 ns as 33 is actually 33.333.

>>   The maximum values give cycle time of 480 ns menaing that the 
>>controller doesn't support PIO mode 0. Hm...

> Even if you clear the enable for the timing register ?

    These fast timing bits are documented as reserved.

> Alan

MBR, Sergei
