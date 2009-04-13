From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: increate the IORDY timeout for the soc 	controllers
Date: Mon, 13 Apr 2009 09:50:01 -0400
Message-ID: <49E34309.1000306@rtr.ca>
References: <20090411160815.GA10995@deprecation.cyrius.com>	 <49E1FCBC.5010101@rtr.ca>	 <c70ff3ad0904130013n319510c4w5ae071076717f2bd@mail.gmail.com>	 <49E334DF.4030703@rtr.ca> <c70ff3ad0904130611u56f43d24me413e27b7bbb3b3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37281 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbZDMNuD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 09:50:03 -0400
In-Reply-To: <c70ff3ad0904130611u56f43d24me413e27b7bbb3b3d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org

saeed bishara wrote:
>>> PIO mode is always used, at least for the identify command. the patch
>>> works and needed for the Kirkwood SoC which runs at 200KHz.
>> ..
>>
>> Errr.. IDENTIFY is often a "special case" command,
>> and rarely, if ever, uses IORDY.
> I think you misunderstand the EDMA IORDY timer
..

Actually, I've been quite familiar with IORDY since 1992 or so.
It generally is only asserted when the drive is managing some
form of elastic buffer between the media and the ATA interface.

In the case of IDENTIFY, many drives will not need to access
the media (though some do), and as a result IORDY won't be used
to stretch the access cycles.

A far better test for your IORDY patch would be to actually use
PIO read/write commands to verify that it works correctly.

Cheers
