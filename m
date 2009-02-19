From: Tejun Heo <tj@kernel.org>
Subject: Re: Storage-Fixup-Entry
Date: Thu, 19 Feb 2009 18:23:08 +0900
Message-ID: <499D24FC.8030003@kernel.org>
References: <4996558D.1020901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55593 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993AbZBSJW4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 04:22:56 -0500
In-Reply-To: <4996558D.1020901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lukas Wymann <dakshinamurti@gmail.com>
Cc: linux-ide@vger.kernel.org

Lukas Wymann wrote:
> Hi
> 
> I have a Laptop Dell Vostro 1500 having these symptoms. Fixed it for now
> as described on http://en.opensuse.org/Disk_Power_Management.
> Maybe it's a candidaten storage-fixup?
> Great work you all doing!!!

1. Can you please attach the output of "smartctl -a" on the drive?

2. How much does start_stop_count increase per hour if you don't
   change any configuration?

3. Which -B value did you use?

Thanks.

-- 
tejun
