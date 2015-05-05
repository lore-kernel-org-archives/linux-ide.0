From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/4] libata: Allow NCQ TRIM to be enabled or disabled with a module parameter
Date: Tue, 05 May 2015 17:57:12 -0400
Message-ID: <yq1k2wmr8lj.fsf@sermon.lab.mkp.net>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
	<20150505133106.GK1971@htj.duckdns.org> <5548CEB2.9000106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23170 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbEEV5S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 17:57:18 -0400
In-Reply-To: <5548CEB2.9000106@suse.de> (Hannes Reinecke's message of "Tue, 05
	May 2015 16:07:46 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Hannes" == Hannes Reinecke <hare@suse.de> writes:

Hannes> As a side note: queue TRIM requires 'SEND FPDMA QUEUED', which
Hannes> is an _optional_ part of the NCQ feature set.  And unfortunately
Hannes> there are no identify bits telling us whether SEND FPDMA QUEUE
Hannes> is actually implemented (or RECEIVE FPDMA QUEUED, for that
Hannes> matter).

Yeah. At least in this case one would assume the command is supported
when queued TRIM is advertised.

But as you saw from my patch series, I have one particular drive that
advertises support for queued READ LOG and yet it fails when you attempt
to use it.

*sigh*

-- 
Martin K. Petersen	Oracle Linux Engineering
