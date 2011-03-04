From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Should minimum_io_size be adjustable (fake 512/4KB drives)?
Date: Fri, 04 Mar 2011 10:07:40 -0500
Message-ID: <yq18vwuhqkj.fsf@sermon.lab.mkp.net>
References: <20110304134315.GA7044@gentoo.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:30513 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1CDPHs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 10:07:48 -0500
In-Reply-To: <20110304134315.GA7044@gentoo.trippels.de> (Markus Trippelsdorf's
	message of "Fri, 4 Mar 2011 14:43:15 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: linux-ide@vger.kernel.org

>>>>> "Markus" == Markus Trippelsdorf <markus@trippelsdorf.de> writes:

Markus> Would there be any (performance) benefit if minimum_io_size
Markus> could be adjusted to 4096 (by the administrator) in this case?

No. The topology information is only used at partitioning/mkfs time.

-- 
Martin K. Petersen	Oracle Linux Engineering
