From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Date: Sun, 27 Feb 2005 17:31:29 +0100
Message-ID: <200502271731.29448.bzolnier@elka.pw.edu.pl>
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl> <20050227073608.GA30796@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:57230 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261595AbVB1NeA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 08:34:00 -0500
In-Reply-To: <20050227073608.GA30796@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Sunday 27 February 2005 08:36, Tejun Heo wrote:
>  Hello, Bartlomiej.
> 
>  This patch should be modified to use flagged taskfile if the
> task_end_request_fix patch isn't applied.  As non-flagged taskfile
> won't return valid result registers, TASK ioctl users won't get the
> correct register output.

Nope, it works just fine because REQ_DRIVE_TASK used only
no-data protocol, please check task_no_data_intr().

>  IMHO, this flag-to-get-result-registers thing is way too subtle.  How
> about keeping old behavior by just not copying out register outputs in
> ide_taskfile_ioctl() in applicable cases instead of not reading
> registers when ending commands?  That is, unless there's some
> noticeable performance impacts I'm not aware of.

This would miss whole point of not _reading_ these registers (IO is slow).
IMHO new flags denoting {in,out} registers should be added (to <linux/ata.h>
to share them with libata) so new code can be sane and old flags would map
on new flags when needed.
