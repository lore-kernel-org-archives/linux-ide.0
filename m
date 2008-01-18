From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: fix off-by-one in error categorization
Date: Fri, 18 Jan 2008 18:37:44 +0900
Message-ID: <47907368.2050507@gmail.com>
References: <477BB9FA.2030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:36954 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbYARJhw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 04:37:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so836039rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 01:37:52 -0800 (PST)
In-Reply-To: <477BB9FA.2030907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ATA_ECAT_DUBIOUS_BASE was too high by one and thus all DUBIOUS error
> categorizations were wrong.  This passed test because only ATA_BUS and
> UNK_DEV were used during testing and the ones after them - ATA_BUS and
> an overflowed entry - behaved similarly.
> 
> This patch fixes the problem by adding DUBIOUS_NONE category and use
> it as base.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Ping.

-- 
tejun
