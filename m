From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4
Date: Tue, 17 Oct 2006 16:54:56 -0400
Message-ID: <45354320.6030009@rtr.ca>
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>	<452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk>	<452F053B.2000906@shaw.ca> <20061013080434.GE6515@kernel.dk>	<45344F4D.6070703@shaw.ca> <45345015.2010601@rtr.ca>	<45345B16.4090505@shaw.ca> <4535032F.2080807@rtr.ca> <adaslhmu8mt.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:39437 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750831AbWJQUy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Oct 2006 16:54:58 -0400
In-Reply-To: <adaslhmu8mt.fsf@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Jens Axboe <jens.axboe@oracle.com>, Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, prakash@punnoor.de

Roland Dreier wrote:
>     Mark> I was thinking more about the non wordsized fields, such as
>     Mark> the various u8 bytes that gcc will lay out differently
>     Mark> depending upon endianess.
> 
> I don't know of any gcc version that changes the order of struct
> fields.  You might be thinking of bitfields, which are laid out in an
> endian-dependent way.

Ack.  And also thinking about other compilers I work with,
which apparently are not so friendly.

You are correct -- I just verified it (again) for myself on x86 & PPC,
and the layout of u8 doesn't change.

Cheers!
