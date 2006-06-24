From: Jeff Garzik <jeff@garzik.org>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sat, 24 Jun 2006 18:43:09 -0400
Message-ID: <449DBFFD.2010700@garzik.org>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64988 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751143AbWFXWnM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jun 2006 18:43:12 -0400
In-Reply-To: <449DBE88.5020809@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: castet.matthieu@free.fr, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>

Data point #3 (or #0...):

This appears to be a _device_ that sends its interrupt early.

If that is the case, the device may appear on any controller, not just 
VIA, and we would have to handle it globally via a device special-case 
in libata-core.

	Jeff



