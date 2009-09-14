From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sr: consider the last written sector when determining
 media size
Date: Tue, 15 Sep 2009 06:54:02 +0900
Message-ID: <4AAEBB7A.3060700@kernel.org>
References: <4AA07D8A.6090004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50183 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbZINVyJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Sep 2009 17:54:09 -0400
In-Reply-To: <4AA07D8A.6090004@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-scsi <linux-scsi@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Milan Kocian <milan.kocian@wq.c>

Tejun Heo wrote:
> On certain cases, UDF disc doesn't report capacity correctly via
> READ_CAPACITY but TOC or trackinfo contains valid information which
> can be obtained using cdrom_get_last_written().  ide-cd considers both
> values and uses the larger one.  Do the same in sr.  This fixes
> bko#9668.
> 
>  http://bugzilla.kernel.org/show_bug.cgi?id=9668
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Milan Kocian <milan.kocian@wq.cz>
> Cc: Jan Kara <jack@suse.cz>

PING.

-- 
tejun
