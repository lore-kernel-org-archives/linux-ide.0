From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Mon, 24 Nov 2008 13:02:11 +0300
Message-ID: <492A7BA3.9000207@ru.mvista.com>
References: <E1L4UpB-0007ro-1g@localhost> <20081124095510.31cc990f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:56240 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751723AbYKXKCS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 05:02:18 -0500
In-Reply-To: <20081124095510.31cc990f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shane McDonald <mcdonald.shane@gmail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>> This patch resurrects the IT8172 IDE controller code.  I began with
>> the 2.6.18 version of the it8172.c file, and have moved it forward so
>>     
>
> This appears to be a PIIX clone, is it different enough to need its own
> driver ?
>   

   Unfortunately, it's not an exact clone, so does need its own driver.

MBR, Sergei


