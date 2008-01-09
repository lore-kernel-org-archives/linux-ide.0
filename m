From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: implement libata.force_cbl
 parameter
Date: Wed, 9 Jan 2008 03:05:02 +0000
Message-ID: <20080109030502.54914b01@lxorguk.ukuu.org.uk>
References: <4783786A.6040608@gmail.com>
	<20080108144004.30a18457@lxorguk.ukuu.org.uk>
	<4784213F.4070203@gmail.com>
	<20080109013728.3b213cfb@lxorguk.ukuu.org.uk>
	<4784275B.8050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41094 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751277AbYAIDHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 22:07:16 -0500
In-Reply-To: <4784275B.8050506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

> > In which case we only need to be able to force UDMA33 or less ?
> 
> Cable detection goes wrong and 40c is detected as 80c.  However, we got

In which case we only (see first question). I don't see why we need to
force anything but "max speed UDMA 33"
