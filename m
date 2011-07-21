From: Tejun Heo <htejun@gmail.com>
Subject: Re: Detection of hot plugging of e-SATA on a port multiplier
Date: Thu, 21 Jul 2011 10:39:26 +0200
Message-ID: <20110721083926.GD3455@htj.dyndns.org>
References: <CAL33XeQQZdknYVJN=XfvnLwdWxBwf1dBbKwQe+MKA7Deo3jsrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:43470 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1GUIjb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jul 2011 04:39:31 -0400
Received: by eye22 with SMTP id 22so1322338eye.2
        for <linux-ide@vger.kernel.org>; Thu, 21 Jul 2011 01:39:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL33XeQQZdknYVJN=XfvnLwdWxBwf1dBbKwQe+MKA7Deo3jsrA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vinit bidkar <vinitbidkar@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, Jul 19, 2011 at 11:41:57AM +0530, vinit bidkar wrote:
> Hi Jeff, Tejun,
> 
> Got your mail
> Need some info detection of e-sata hot plug connected to a port multiplier.
> 
> System:
> Kernel - 2.6.x
> PMP - Marvell make
> 
> There is one internal HDD on port 0 and provision to hot plug e-SATA on port
> 1 of the PMP.
> 
> Internal HDD gets detected at bootup. No problems here.
> 
> MY PROBLEM - How to detect e-SATA when the system is running (hot plug).
> 
> MY PROBABLE SOLUTION - Keep polling the PMP ports to find attachment and
> detachment of e-SATA on various ports and inform the application about the
> same.

Eh?  Why doesn't it work automatically?  Doesn't the host controller
support Snotification?

-- 
tejun
