From: Tejun Heo <htejun@gmail.com>
Subject: Re: Do ICH10+AHCI-driver support port-multiplying on a eSATA port?
Date: Mon, 12 Jan 2009 10:44:22 +0900
Message-ID: <496AA076.8080205@gmail.com>
References: <1231513287.2631.68.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:42629 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbZALBo3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 20:44:29 -0500
In-Reply-To: <1231513287.2631.68.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux-ide <linux-ide@vger.kernel.org>

Soeren Sonnenburg wrote:
> Dear all,
> 
> I am trying to connect an external 2-disk case (eCube II  see
> http://www.one-tech.com/EN/htm_ecube.htm) to an ICH10 skyburg dp45sg
> board via eSATA. As the case requires a port-multiplying sata card, I am
> wondering if ich10+ahci support it?
> 
> At least with 2.6.27.10 I am seeing only one drive. Connecting the case
> via usb gives two (dmesg parts below).
> 
> So is port multiplying not yet available for ahci or not at all or does
> the the ich10 not support it and I should rather try a sil 3132 or so?

ahci on ich10 can do port multiplier.  I can't tell from the web page
but if it's one of simg5723 and its friends, you'll need to put it
into JBOD mode using the dip switch or whatever.

-- 
tejun
