From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 22:24:55 -0700
Message-ID: <46FDE1A7.6030102@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:34950 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbXI2F0k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 01:26:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3775449wah
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 22:26:39 -0700 (PDT)
In-Reply-To: <46FDADD9.9050007@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Polling ALREADY makes the job of fixing SAS/SATA exception handling
> difficult.  Expanding polling to something SAS/SATA controllers treat as
> fundamentally irq-driven and integrated with the rest of the command
> flow is moving in the wrong direction.
> 
> To re-re-re-summarize, polling in PMP is fundamentally broken for an
> ENTIRE CLASS OF HARDWARE that we actively support today.  And
> jgarzik/misc-2.6.git#sas is adding two more controllers to that list.

As an interim solution, it doesn't make anything worse tho.  Those
drivers don't support PMP anyway.  After rc1 merge, polling PMP access
can be replaced with new qc_issue (probably ata_exec_internal) based code.

The question here is whether it's worth to include PMP support with
polling PMP register access as an interim solution for 2.6.24.  I think
it will be beneficial for both user convenience and testing as long as
the said change is made soon after -rc1.

My vote is yes but this kind of decision ultimately falls on the
subsystem maintainer, so it's your call, Jeff.

Thanks.

-- 
tejun
