From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 08 Apr 2010 12:33:04 -0400
Message-ID: <yq1tyrlx5tr.fsf@sermon.lab.mkp.net>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net>
	<alpine.DEB.1.10.1004081811200.21305@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:56375 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758788Ab0DHQdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 12:33:17 -0400
In-Reply-To: <alpine.DEB.1.10.1004081811200.21305@uplift.swm.pp.se> (Mikael
	Abrahamsson's message of "Thu, 8 Apr 2010 18:12:37 +0200 (CEST)")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

>>>>> "Mikael" == Mikael Abrahamsson <swmike@swm.pp.se> writes:

>> For unknown reasons these drive report themselves as 512-byte drives
>> despite using 4096-byte sectors internally.

Mikael> It's not unknown, it's for compatibility reasons.

We still haven't been given a comprehensive explanation.  "It breaks
something for someone" doesn't really give us much to work with...

-- 
Martin K. Petersen	Oracle Linux Engineering
