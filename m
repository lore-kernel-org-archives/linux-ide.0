From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sch: fix PSTS register reading.
Date: Wed, 20 Jan 2010 13:37:55 +0000
Message-ID: <20100120133755.37f6e54f@lxorguk.ukuu.org.uk>
References: <4B56ECD2.20107@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34082 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751261Ab0ATNl7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 08:41:59 -0500
In-Reply-To: <4B56ECD2.20107@compulab.co.il>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denis Turischev <denis@compulab.co.il>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

O> According to Poulsbo SCH datasheet (p. 353): "Reading reserved bits returns
> an indeterminate, inconsistent value".

Ok but 

> Bit 7 of PSTS register read as 1 when there is slave disk drive attached,
> despite being described as reserved with zero value. This causes wrong 
> feature decoding in ata_sff_tf_read.

The feature/error register doesn't have reserved bits so your patch and
diagnostic don't seem to make sense.

If the top bit is set in your error register post reset it is because you
have a device flagging a fail

0x81 means the slave flagged a fail
0x80/82-FF means both devices flagged a fail

