From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 02 Feb 2007 20:49:11 +0900
Message-ID: <45C32537.9010505@gmail.com>
References: <20070202063748.GC1625@htj.dyndns.org> <20070202100856.706bd1e8@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:28196 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXBBLtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 06:49:16 -0500
Received: by wx-out-0506.google.com with SMTP id h31so870947wxd
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 03:49:15 -0800 (PST)
In-Reply-To: <20070202100856.706bd1e8@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan wrote:
>> Note that both normal commands and EH commands timeouts are adjusted
>> to 7 secs, but cache flushses still have 30sec timeout.  This is a
>> side effect of the way sd makes use of sdev->timeout, but this is a
>> good side effect in that ATA spec requires cache flushes are given
>> longer timeout.
> 
> Our cache flush handling still appears to be questionable if not wrong.
> Not sure how SCSI expects it to behave but for ATA we should call it
> again on a fatal media error.

Planning on doing that soon.  Thanks.

-- 
tejun
