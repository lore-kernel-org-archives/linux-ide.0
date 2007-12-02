From: Daniel Drake <dsd@gentoo.org>
Subject: Re: program to test various ATAPI transfer lengths (and brasero bugs)
Date: Sun, 02 Dec 2007 21:07:41 +0000
Message-ID: <47531E9D.4070109@gentoo.org>
References: <474C3803.7020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:64349 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXLBVHf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 16:07:35 -0500
In-Reply-To: <474C3803.7020008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Here's the program I used to test various ATAPI transfer lengths based
> on the sample code Daniel Drake posted a while ago.  The code Daniel
> Drake posted was taken from brasero and had the following bug.
> 
> Byte 7 is high byte of alloc size not low and the whole CDB should be
> ten bytes long instead of nine.  SPC tries to trick you here by omitting
> byte 5 in Reserved field.
> 
> Daniel, care to forward this to brasero developers?

Well spotted! Thanks a lot for looking into this. I've sent a fix to the 
brasero developers.

Daniel

