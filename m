From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Fw: [PATCH] ahci: add ACard 8620 support (rough draft)
Date: Mon, 20 Apr 2009 10:40:48 -0400
Message-ID: <49EC8970.2000000@garzik.org>
References: <000d01c9b815$73006700$b500a8c0@JasonWuNB> <49E31219.1000301@acard.com> <49E323E1.90907@garzik.org> <49E3F4B0.1080909@acard.com> <49E40597.8070901@gmail.com> <49EC56F6.5000602@acard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51310 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686AbZDTOkz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2009 10:40:55 -0400
In-Reply-To: <49EC56F6.5000602@acard.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jimyeh98@acard.com
Cc: Tejun Heo <htejun@gmail.com>, jason wu <jason_wu@acard.com>, =?UTF-8?B?IuiOiuaWh+iIiShKYXNvbiBDaHVhbmcpIg==?= <jason@acard.com>, =?UTF-8?B?IumZs+WKm+iqoChSaWNoYXJkIENoZW4pIg==?= <rchern@acard.com>, =?UTF-8?B?Iue/geiMguizgChEYW5pZWwgV2VuZyki?= <dweng@acard.com>, =?UTF-8?B?IuWQs+S9s+eSiyhMYXVyZW5jZSBXdSki?= <laurence@acard.com>, =?UTF-8?B?IumZs+W+t+WogShEZXJ3ZWkgQ2hlbiki?= <derwei@acard.com>, =?UTF-8?B?IumZs+mHkea4hShHZWluZ0NoaW5nIENoZW4pIg==?= <geingching@acard.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

Jim Yeh wrote:
> Hi, Tejun and Jeff,
> 
> The PCB samples was sent early today. There are two PCB inside, the PCB 
> AEC6293 is for IC ATP8620, the other one is for IC ATP8624. The quick 
> installation guide and latest version datasheet was attached. Fedex 
> tracking no. is listed below. Any question please let me know.

(removed linux-kernel mailing list from CC)

Thank you for these cards and documents.  Unfortunately the documents 
will not be much help with the driver, because they do not include 
information on registers and DMA data structures.

Many months ago, you gave me permission to post this in our hardware 
document archive for programmers:
http://gkernel.sourceforge.net/specs/acard/ATP8620pub_Rev0.98.pdf



Do you have updated documents for 8620 and 8624, that include register 
and DMA data structure information?

If yes, may we have permission to post these in our programmer's archive 
on the Web?  http://gkernel.sourceforge.net/specs/

Thanks and best regards,

	Jeff


