From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/2] pata_atiixp: update port enabledness
 test handling
Date: Fri, 16 Jan 2009 15:32:04 +0900
Message-ID: <497029E4.40902@kernel.org>
References: <497028CF.7030408@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36706 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276AbZAPGcF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 01:32:05 -0500
In-Reply-To: <497028CF.7030408@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, bugsbuggy@ymail.com

Tejun Heo wrote:
> Port enabledness test fits much better into init_one() instead of
> pre_reset().  The reason why these tests are in pre_reset() is purely
> historical at this point.  Move it to init_one().  This will help
> further changes.

Eh... I'm holding the second patch for now.  Will follow up later.

Thanks.

-- 
tejun
