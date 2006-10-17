From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4
Date: Tue, 17 Oct 2006 10:58:34 -0700
Message-ID: <adaslhmu8mt.fsf@cisco.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>
	<452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk>
	<452F053B.2000906@shaw.ca> <20061013080434.GE6515@kernel.dk>
	<45344F4D.6070703@shaw.ca> <45345015.2010601@rtr.ca>
	<45345B16.4090505@shaw.ca> <4535032F.2080807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:47753 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1750777AbWJQR6h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 13:58:37 -0400
In-Reply-To: <4535032F.2080807@rtr.ca> (Mark Lord's message of "Tue, 17 Oct 2006 12:22:07 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Robert Hancock <hancockr@shaw.ca>, Jens Axboe <jens.axboe@oracle.com>, Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, prakash@punnoor.de

    Mark> I was thinking more about the non wordsized fields, such as
    Mark> the various u8 bytes that gcc will lay out differently
    Mark> depending upon endianess.

I don't know of any gcc version that changes the order of struct
fields.  You might be thinking of bitfields, which are laid out in an
endian-dependent way.

 - R.
