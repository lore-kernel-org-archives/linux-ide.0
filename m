From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2 resend] libata-sff: avoid byte swapping in ata_sff_data_xfer()
Date: Tue, 17 Feb 2009 21:07:03 +0300
Message-ID: <499AFCC7.60403@ru.mvista.com>
References: <200902152230.38271.sshtylyov@ru.mvista.com> <4998717A.2090507@pobox.com> <49987672.2050102@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28517 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753090AbZBQSGn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2009 13:06:43 -0500
In-Reply-To: <49987672.2050102@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello, I wrote:

>>> Handling of the trailing byte in ata_sff_data_xfer() is suboptimal 
>>> bacause:

>>> - it always initializes the padding buffer to 0 which is not really 
>>> needed in
>>>   both the read and write cases;

>>> - it has to use memcpy() to transfer a single byte from/to the 
>>> padding buffer;

>> Have you looked at the assembly, before deciding it is suboptiomal?

>    I'm estimating the code itself, not what the compiler can do to fix 
> it. :-)

>> gcc optimizes tiny arrays and structures quite well, and is well 
>> capable of seeing one path where the initialization is clobbered 
>> without a single read, and another code path where it is used.

>    The initialier just shouldn't have been there in the first place, 
> clobbered or not. And let's looks at what gcc gave me:

[...]

>> As for memcpy, for small and/or constant values that is quite often a 
>> compiler builtin.  It is rarely useful, these days, to convert a 
>> memcpy() to a hand-rolled 

> version of same.

>    Here memcpy() just shouldn't have appeared in the first place. But 
> indeed, gcc did optimize it away.

    In fact, we could do without both memcpy and io*15_rep() I think:

  	if (unlikely(buflen & 0x01)) {
		u16 pad;

		/* Point buf to the tail of buffer */
		buf += buflen - 1;

		/*
		 * Copy from/to pad's LSB only (host order),
		 * dropping its MSB or zero-extending it...
		 */
  		if (rw == READ) {
			pad = ioread16(data_addr);
			*buf = (unsigned char)pad;
  		} else {
			pad = *buf;
			iowrite16(pad, data_addr);
		}
	}

    It should work -- that easy... although io{read|write}16() will still 
byte-swap.

>>     Jeff

MBR, Sergei
