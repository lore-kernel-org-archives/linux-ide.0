From: Mark Lord <liml@rtr.ca>
Subject: Re: Acard ATP8620 2SATA / 1 IDE  driver - AHCI.C Nov082007
Date: Thu, 08 Nov 2007 14:52:26 -0500
Message-ID: <473368FA.4030603@rtr.ca>
References: <00b501c81ace$ece895f0$6200a8c0@jameshsu> <47270656.7080205@garzik.org> <003701c81c63$cee89c30$6200a8c0@jameshsu> <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence> <005e01c821fb$502be120$6200a8c0@jameshsu> <20071108162229.GB31492@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4636 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761040AbXKHTw1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 14:52:27 -0500
In-Reply-To: <20071108162229.GB31492@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Jeff Garzik wrote:
>..
> 2) This chip includes target mode support.  Very nice, well done!
> I hope that standard AHCI eventually supports this nice feature!
..

Speaking of which.  Do we have a strategy as to how to implement/support
the target side of target mode on controllers which can do it?

The Marvell chips also have a target mode feature, and I'd like to add
support for it soon-ish, but it's now clear how you would like it plumbed
into libata.

It's almost like a separate driver/subsystem, except that would be very silly.

???
