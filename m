From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Tue, 02 Jan 2007 13:18:32 -0500
Message-ID: <459AA1F8.7080402@rtr.ca>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org> <459A9AA8.5060808@rtr.ca> <459A9D81.8040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1153 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754870AbXABSSf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 13:18:35 -0500
In-Reply-To: <459A9D81.8040904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
..
>> hdparm *does* try to issue the PACKET IDENTIFY whenever
>> a regular IDENTIFY fails.  Currently these all go through
>> the HDIO_DRIVE_CMD ioctl().  I don't have a system set up
>> here that has any ATAPI over libata to test with.
>> Could you perhaps try and see where that ioctl() is failing?
> 
> Ah.. Okay, so that's the second HDIO_DRIVE_CMD.  I'll test why the
> second one is failing tomorrow.
> 

Okay, I suspect it's failing because libata-scsi *always*
forces passthru commands to go via atapi_xlat, even when
the command itself is not a PACKET command.  Doh!

I'll see if there's a sensible easy fix for it, and maybe post
a patch here unless you beat me to it.

Cheers
