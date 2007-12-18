From: Jeff Garzik <jeff@garzik.org>
Subject: Re: git repo and #upstream merging
Date: Mon, 17 Dec 2007 20:54:14 -0500
Message-ID: <47672846.4050609@garzik.org>
References: <11976987063011-git-send-email-htejun@gmail.com> <4763711A.8010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47560 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbXLRByQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:54:16 -0500
In-Reply-To: <4763711A.8010204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: hancockr@shaw.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Tejun Heo wrote:
>> This is the second take of improve-ACPI-corner-case-handling patchset
>> and contains the following ten patches.
> 
> Jeff, this patchset can also be pulled from the following git tree.
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git acpi-fixes
> 
> Also, merging this into #upstream can cause some interesting conflicts
> w/ ACPI timing handling update patches.  If you ACK the patchset, I'll
> prep merged git HEAD for you.

It was easier for me to

* merge the patches into #upstream-fixes

* rebase #upstream on top of #upstream-fixes,
	while dropping the conflicting ACPI patches

And IMO that gives you a bit more freedom to do the merged git -- though 
that obviously implies you will need to resend the ACPI patchset that 
you had previously submitted.

	Jeff



