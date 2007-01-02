From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Tue, 02 Jan 2007 16:52:17 -0500
Message-ID: <459AD411.1010307@rtr.ca>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org> <459A9AA8.5060808@rtr.ca> <459A9D81.8040904@gmail.com> <459AA1F8.7080402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1846 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbXABVwP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 16:52:15 -0500
In-Reply-To: <459AA1F8.7080402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

(pardon the duplicate posting -- just trying to get it into the correct thread).

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
..
>>> Support for IDENTIFY PACKET DEVICE would be nice too.
>> It already does that, using HDIO_DRIVE_CMD to retrieve it
>> in the same way as for regular IDENTIFY DEVICE commands.
>
> Hmmm... My hdparm doesn't seem to do that.
>
> # hdparm -V
> hdparm v6.9
> # hdparm -I /dev/sr0
>
> /dev/sr0:
>  HDIO_DRIVE_CMD(identify) failed: Input/output error
>
> Am I missing something?

Okay, I've dug through the code and found bugs in SCSI and libata.
After fixing those, "hdparm -I" now works unmodified for libata ATAPI.

I'll post fixes shortly, after some more testing.

Cheers
