From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: use new sata phy register settings for new
 devices
Date: Mon, 13 Apr 2009 03:34:04 -0400
Message-ID: <49E2EAEC.5030606@garzik.org>
References: <20090411160809.GA10922@deprecation.cyrius.com>	 <da824cf30904111502u50d8f55dj2d0414bb45a49a22@mail.gmail.com> <c70ff3ad0904130026r4aac1ef4le36175ecdfed581c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40427 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbZDMHeN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 03:34:13 -0400
In-Reply-To: <c70ff3ad0904130026r4aac1ef4le36175ecdfed581c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Grant Grundler <grundler@google.com>, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

saeed bishara wrote:
>> Any chance these magic numbers can be documented?
>>
>> No objection to this patch and I would prefer a follow on
>> patch to document the bits if that's possible.
> Grant,
>     those bits control analog/electrical settings of the sata phy
> module, the functional spec uses acronyms to name it, and without much
> documentation for it.

Named constants based on acronyms are preferable to numeric constants. 
A little information and disambiguation is better than none at all.

	Jeff



