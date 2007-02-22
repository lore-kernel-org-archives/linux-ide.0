From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add NCQ blacklist entries from Silicon Image
  Windows driver
Date: Thu, 22 Feb 2007 09:41:25 -0500
Message-ID: <45DDAB95.6070903@rtr.ca>
References: <45DD2EC9.4050403@shaw.ca> <45DD3EC7.3050801@garzik.org> <20070222113226.GI5549@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2169 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933094AbXBVOl2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Feb 2007 09:41:28 -0500
In-Reply-To: <20070222113226.GI5549@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>

Jens Axboe wrote:
>> Robert Hancock wrote:
>..
>>> +    /* The following blacklist entries are taken from the Windows
>>> +       driver .inf files for the Silicon Image 3124 and 3132. */
>>> +    { "Maxtor 7B250S0",    "BANC1B70",    ATA_HORKAGE_NONCQ, },
>>> +    { "HTS541060G9SA00",    "MB3OC60D",    ATA_HORKAGE_NONCQ, },
>>> +    { "HTS541080G9SA00",    "MB4OC60D",    ATA_HORKAGE_NONCQ, },
>>> +    { "HTS541010G9SA00",    "MBZOC60D",    ATA_HORKAGE_NONCQ, },
>> Do we have information that these drives fail on non-SiI controllers?
>>
>> Sometimes the problem can be related to a single family of controllers.
> 
> I don't know about the Hitachi's, but the Maxtor with that firmware is
> definitely broken. It _appeared_ to work if the depth was limited to 4,
> but I didn't test it long enough to be absolutely certain. So the safest
> is indeed to blacklist it.

Yes, broken on the Silicon Image controllers for sure.
But what type of controller did you observe the failures on, Jens ?
