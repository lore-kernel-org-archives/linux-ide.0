From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Thu, 24 Aug 2006 01:24:08 +0900
Message-ID: <44EC8128.2040204@gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:9316 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965013AbWHWQYP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Aug 2006 12:24:15 -0400
Received: by py-out-1112.google.com with SMTP id n25so284970pyg
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2006 09:24:14 -0700 (PDT)
In-Reply-To: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com

Fajun Chen wrote:
> Hi Folks,
> 
> I used Linux 2.6.18-rc2 with Jeff Garzik's git libata patch for new EH, 
> hotplug,
> and pata support. Hardware is ARM IOP80321 with PCI-X. Host adapters
> is pata Sil680.  The sequence of actions are "power off drive ->
> remove drive -> power on drive -> add drive" and there's kernel errors
> while adding the drive.  Complete dmesg traces attached. Has anyone
> seen this problem before?

Can you please try the latest -mm?

-- 
tejun
