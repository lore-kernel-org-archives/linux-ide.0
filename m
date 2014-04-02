From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Wed, 2 Apr 2014 13:09:16 -0400
Message-ID: <20140402170916.GH16631@htj.dyndns.org>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:37744 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456AbaDBRJT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2014 13:09:19 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so494493qgd.23
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2014 10:09:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, Chris Samuel <chris@csamuel.org>, Marc MERLIN <marc@merlins.org>

On Tue, Apr 01, 2014 at 08:42:36PM -0400, Martin K. Petersen wrote:
> From: "Martin K. Petersen" <martin.petersen@oracle.com>
> 
> Now that drives with support for queued trim are starting to appear, it
> would be helpful to expose the chosen trim mode to userland. Create a

Can you please be a bit more elaborate with how it'd be helpful?  Do
we have actual use cases for it?

Thanks.

-- 
tejun
