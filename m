From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/20] ide: convert "empty" REQ_TYPE_ATA_CMD requests to use REQ_TYPE_ATA_TASKFILE
Date: Thu, 13 Dec 2007 14:54:52 +0100
Message-ID: <200712131454.53053.bzolnier@gmail.com>
References: <200712092217.32139.bzolnier@gmail.com> <47612BAE.5030109@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:8838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbXLMNps (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 08:45:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so871404ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 05:45:40 -0800 (PST)
In-Reply-To: <47612BAE.5030109@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Thursday 13 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Based on the previous work by Tejun Heo.
> 
> > There should be no functionality changes caused by this patch.
> 
>     I didn't get the point. Why do you consider them "empty"?

These requests don't have command buffer (in case of REQ_TYPE_ATA_CMD)
or ide_task_t (REQ_ATA_TYPE_ATA_TASKFILE) attached to them.

[ Please see execute_drive_cmd() for details. ]

Bart
