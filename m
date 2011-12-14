From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/3] [SCSI] sd: fix runtime status check in sd_shutdown
Date: Wed, 14 Dec 2011 14:58:03 +0400
Message-ID: <4EE8813B.1090802@mvista.com>
References: <1323832681-7177-1-git-send-email-ming.m.lin@intel.com> <1323832681-7177-2-git-send-email-ming.m.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47278 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1LNK7E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2011 05:59:04 -0500
In-Reply-To: <1323832681-7177-2-git-send-email-ming.m.lin@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Bottomley <JBottomley@parallels.com>, Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org

Hello.

On 14-12-2011 7:17, Lin Ming wrote:

> Commit af8db15 disabled device's runtime PM during shutdown.

    Please also specify that commit's summary in parens.

> So sd's runtime status can't be checked with pm_runtime_suspended(dev)
> any more.

> Fix it by checking runtime status with pm_runtime_status_suspended(dev).

> Signed-off-by: Lin Ming<ming.m.lin@intel.com>

WBR, Sergei

