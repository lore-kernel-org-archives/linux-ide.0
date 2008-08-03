From: Tejun Heo <tj@kernel.org>
Subject: Re: smartctl -a output on crazy-unloading drives
Date: Sun, 03 Aug 2008 20:05:46 +0900
Message-ID: <4895910A.5080305@kernel.org>
References: <4892D1F9.5060106@kernel.org> <4892D34F.7040501@gmx.net> <489526B5.9020001@kernel.org> <48958F70.8090907@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42040 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbYHCLGV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 07:06:21 -0400
In-Reply-To: <48958F70.8090907@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Stegmann <tobias_stegmann@gmx.net>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

(restoring linux-ide cc)

Tobias Stegmann wrote:
> Yes, I'm using the APM setting between 6 and 12 months now. If I'm using
> standard APM settings, the Load_Cycle_Counts increases very fast and
> there is this clicking noise I can hear.
> I'm not quite sure, but I think its rated for over 1.500.000 LCCs.

Can you please turn off APM setting and see how much Load_Cycle_Counts
increases in an hour under light usage?

Thanks.

-- 
tejun
