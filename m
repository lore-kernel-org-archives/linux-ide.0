From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Highpoint 2220
Date: Tue, 06 Feb 2007 16:02:59 -0500
Message-ID: <45C8ED03.8080409@garzik.org>
References: <20070206140152.313D2690044@pitor.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54466 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965468AbXBFVDD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 16:03:03 -0500
In-Reply-To: <20070206140152.313D2690044@pitor.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: info@pitor.hu
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

info@pitor.hu wrote:
> My problem is it does not work with kernel sata_mv driver, only highpoint's binary hptvm6 driver, which is very slow.
> I would like to know when will the kernel support Highpoint 2220(Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 07))


sata_mv has supported the 6081 for years.  Maybe you just need to add a 
PCI ID or try a newer kernel.

	Jeff


