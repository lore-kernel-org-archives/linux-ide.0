From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] Add factory recertified Crucial M500s to blacklist
Date: Wed, 26 Aug 2015 11:24:31 -0400
Message-ID: <yq1si762hu8.fsf@sermon.lab.mkp.net>
References: <1440570553-1600-1-git-send-email-g@maral.me>
	<1440570553-1600-2-git-send-email-g@maral.me>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43939 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbbHZPYm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2015 11:24:42 -0400
In-Reply-To: <1440570553-1600-2-git-send-email-g@maral.me> (Guillermo
	A. Amaral's message of "Tue, 25 Aug 2015 23:29:13 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Guillermo A. Amaral" <g@maral.me>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

>>>>> "Guillermo" == Guillermo A Amaral <g@maral.me> writes:

Guillermo> The Crucial M500 is known to have issues with queued TRIM
Guillermo> commands, the factory recertified SSDs use a different model
Guillermo> number naming convention which causes them to get ignored by
Guillermo> the blacklist.

No particular objection to the patch. But I have asked Micron for
details since this may affect more of the blacklist entries.

-- 
Martin K. Petersen	Oracle Linux Engineering
