From: Tejun Heo <htejun@gmail.com>
Subject: Re: git repo and #upstream merging
Date: Sat, 15 Dec 2007 15:15:54 +0900
Message-ID: <4763711A.8010204@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:8496 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbXLOGQB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:16:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1196280rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:16:00 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This is the second take of improve-ACPI-corner-case-handling patchset
> and contains the following ten patches.

Jeff, this patchset can also be pulled from the following git tree.

  master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git acpi-fixes

Also, merging this into #upstream can cause some interesting conflicts
w/ ACPI timing handling update patches.  If you ACK the patchset, I'll
prep merged git HEAD for you.

Thanks.

-- 
tejun
