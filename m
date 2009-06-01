From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2 resend] libata-sff: avoid byte swapping in ata_sff_data_xfer()
Date: Mon, 01 Jun 2009 23:31:13 +0400
Message-ID: <4A242C81.3080309@ru.mvista.com>
References: <200902152230.38271.sshtylyov@ru.mvista.com> <49DB199C.3040305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58572 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbZFAT35 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jun 2009 15:29:57 -0400
In-Reply-To: <49DB199C.3040305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello, I wrote:

>> Handling of the trailing byte in ata_sff_data_xfer() is suboptimal 
>> bacause:

>> - it always initializes the padding buffer to 0 which is not really 
>> needed in
>>   both the read and write cases;

>> - it has to use memcpy() to transfer a single byte from/to the padding 
>> buffer;

>> - it uses io{read|write}16() accessors which swap bytes on the big 
>> endian CPUs
>>   and so have to additionally convert the data from/to the little 
>> endian format
>>   instead of using io{read|write}16_rep() accessors which are not 
>> supposed to
>>   change the byte ordering.
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>   Jeff, have you forgotten about this one?

    PING.

MBR, Sergei
