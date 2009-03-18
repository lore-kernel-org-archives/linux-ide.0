From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-core Use more robust parsing for multi_count
Date: Wed, 18 Mar 2009 11:06:36 -0400
Message-ID: <49C10DFC.2070206@rtr.ca>
References: <49C1047D.4000008@rtr.ca> <20090318143230.2b64e273@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34655 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbZCRPGn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 11:06:43 -0400
In-Reply-To: <20090318143230.2b64e273@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> +			switch (dev->id[59] & 0xff) {
> 
> Umm surely...
> 
> 	if (n & (n - 1))
..

????

Eg. for n = 5:  (5 & 4) == "true", but not a power of two.

????
