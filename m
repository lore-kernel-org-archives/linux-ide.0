From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: increate the IORDY timeout for the soc 	controllers
Date: Mon, 13 Apr 2009 08:49:35 -0400
Message-ID: <49E334DF.4030703@rtr.ca>
References: <20090411160815.GA10995@deprecation.cyrius.com>	 <49E1FCBC.5010101@rtr.ca> <c70ff3ad0904130013n319510c4w5ae071076717f2bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33147 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbZDMMtj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 08:49:39 -0400
In-Reply-To: <c70ff3ad0904130013n319510c4w5ae071076717f2bd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org

saeed bishara wrote:
> On Sun, Apr 12, 2009 at 5:37 PM, Mark Lord <liml@rtr.ca> wrote:
>> Martin Michlmayr wrote:
>>> From: Saeed Bishara <saeed@marvell.com>
> 
>> I want to see somebody actually test/verify that
>> this works with PIO/MWDMA2 devices (eg. CF cards) first.
>>
>> Test results?
> PIO mode is always used, at least for the identify command. the patch
> works and needed for the Kirkwood SoC which runs at 200KHz.
..

Errr.. IDENTIFY is often a "special case" command,
and rarely, if ever, uses IORDY.

How about some other result?

The past couple of patches from you before these *broke* the driver,
which is why I'd like to see this and future patches verified first.

Thanks.
