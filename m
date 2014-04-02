From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Wed, 02 Apr 2014 13:26:16 -0400
Message-ID: <yq1zjk3wslj.fsf@sermon.lab.mkp.net>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
	<20140402170916.GH16631@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18745 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758860AbaDBR0c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2014 13:26:32 -0400
In-Reply-To: <20140402170916.GH16631@htj.dyndns.org> (Tejun Heo's message of
	"Wed, 2 Apr 2014 13:09:16 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, Chris Samuel <chris@csamuel.org>, Marc MERLIN <marc@merlins.org>

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

>> Now that drives with support for queued trim are starting to appear,
>> it would be helpful to expose the chosen trim mode to
>> userland. Create a

Tejun> Can you please be a bit more elaborate with how it'd be helpful?
Tejun> Do we have actual use cases for it?

There have been several threads on linux-btrfs and elsewhere where
people have asked whether queued trim is supported by their drive or
not. This information currently isn't reported anywhere. I thought it
would be convenient to have a sysfs attribute that people could inspect
to find out.

-- 
Martin K. Petersen	Oracle Linux Engineering
