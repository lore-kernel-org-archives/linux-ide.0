From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI 3512 Serial ATA Controller - kernel 2.6.23
Date: Sat, 02 Feb 2008 12:04:50 +0900
Message-ID: <47A3DDD2.2010600@gmail.com>
References: <Pine.LNX.4.63.0801222230470.4758@crystal.rdstm.ro> <47965AA7.4080703@garzik.org> <Pine.LNX.4.63.0801231244040.28840@crystal.rdstm.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:28538 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012AbYBBDE5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 22:04:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so950079rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 19:04:56 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0801231244040.28840@crystal.rdstm.ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Nica <timi@crystal.rdstm.ro>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Dan Nica wrote:
> those errors apears only when I use the harddrives with
> the sii controller and only when I make operation between
> the onboard sata and the sii sata controller, operations between 
> ide and drives that are on sii works perfectly...

Hmm.. Your drive is raising ABRT on writes.  It can point to a number of
things including media access error and transmission error.  It's
basically a catch-all bit.  In the log, libata EH slowed down the device
to udma33 without any effect so I don't think it's transmission error
caused by cable misdetection or miswiring (mid connector connected to
the only drive on the cable).  What does 'smartctl -a' say about the drive?

-- 
tejun
