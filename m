From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/03] sata_mv: PHY_MODEx errata fixes
Date: Fri, 30 May 2008 19:20:51 -0400
Message-ID: <48408BD3.5070006@rtr.ca>
References: <483C8328.1030807@rtr.ca> <483C838F.9060208@rtr.ca> <48407B79.4090303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2433 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbYE3XUx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 19:20:53 -0400
In-Reply-To: <48407B79.4090303@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Fix and update the errata handling for the PHY_MODEx registers.
>> This improves receiver noise tolerance, among other things.
..
>> +        /* enforce bit restrictions on GenIIe devices */
>> +        if (IS_GEN_IIE(hpriv))
>> +            m4 = (m4 & ~0x5DE3FFFC) | (1 << 2);
> 
> can this magic number become a named constant?  do we know the bits, can 
> they be broken out and enumerated?
..

Heh..

I simply copied it over from the Marvell driver,
and the folks at Marvell ack'd it without responding
to my request for a pointer to an errata doc somewhere.

But as it turns out, I do have something here that describes it.
The code seems to be just masking away all of the reserved bits,
which need to be written as zeros on every access.
Except for reserved bit2, which has to be written as 1 on every write.

I'll break that up into a pair of suitable constants.
So it will look something like this, after passing it by Marvell:

	if (IS_GEN_IIE(hpriv))
		m4 = (m4 & ~PHY_MODE4_RSVD_ZEROS) | PHY_MODE4_RSVD_ONES;

How's that look to you?

Cheers



