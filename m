From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Sun, 22 Jul 2007 21:20:29 +0900
Message-ID: <46A34B8D.3040407@gmail.com>
References: <8202f4270707200814ja0ba571oa38e25fc2f731a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:19694 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267AbXGVMUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 08:20:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so32799rvb
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 05:20:35 -0700 (PDT)
In-Reply-To: <8202f4270707200814ja0ba571oa38e25fc2f731a8d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> Yasha Okshtein wrote:
>> I need to send soft and/or hard resets from userspace.
> 
>>> Actually, you can do it by requesting manual rescan of the SCSI host.
>>> "echo - - - > /sys/class/scsi_host/hostX/scan"
> 
> I've been using this approach to spin up a PATA drive. However,  I
> have not figured out a way to return user scan result from kernel.
> For instance, how can I tell if the scan failed at reset or Identify
> Device from user space?

Hmm... As it currently stands, you cannot.

-- 
tejun
