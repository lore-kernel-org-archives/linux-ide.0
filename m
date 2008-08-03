From: Tejun Heo <tj@kernel.org>
Subject: Re: smartctl -a output on crazy-unloading drives
Date: Sun, 03 Aug 2008 23:04:42 +0900
Message-ID: <4895BAFA.4050909@kernel.org>
References: <4892D1F9.5060106@kernel.org> <4892D34F.7040501@gmx.net> <489526B5.9020001@kernel.org> <48958F70.8090907@gmx.net> <4895910A.5080305@kernel.org> <4895A9F4.9000402@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53280 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297AbYHCOFQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 10:05:16 -0400
In-Reply-To: <4895A9F4.9000402@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Stegmann <tobias_stegmann@gmx.net>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tobias Stegmann wrote:
> The results:
> 
> 1 hour surfing, hearing mp3 files: 24 Load Cycles
> Then idling for a few minutes: ~5 LCCs/minute		

5 cycles per minute.  Impressive even w/ 1.5mil rate.  Thanks for testing.

-- 
tejun
