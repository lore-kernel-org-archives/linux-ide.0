From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Date: Tue, 01 Mar 2005 00:24:17 +0900
Message-ID: <422337A1.4060806@gmail.com>
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl> <20050227073608.GA30796@htj.dyndns.org> <200502271731.29448.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.195]:11342 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261645AbVB1PYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2005 10:24:47 -0500
Received: by wproxy.gmail.com with SMTP id 68so936536wri
        for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2005 07:24:46 -0800 (PST)
In-Reply-To: <200502271731.29448.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

  Hi,

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 27 February 2005 08:36, Tejun Heo wrote:
> 
>> Hello, Bartlomiej.
>>
>> This patch should be modified to use flagged taskfile if the
>>task_end_request_fix patch isn't applied.  As non-flagged taskfile
>>won't return valid result registers, TASK ioctl users won't get the
>>correct register output.
> 
> 
> Nope, it works just fine because REQ_DRIVE_TASK used only
> no-data protocol, please check task_no_data_intr().
> 

  Sorry, I missed that.  IDE really has a lot of ways to finish a 
command, doesn't it?  hdio.txt is gonna look ugly. :-)

> 
>> IMHO, this flag-to-get-result-registers thing is way too subtle.  How
>>about keeping old behavior by just not copying out register outputs in
>>ide_taskfile_ioctl() in applicable cases instead of not reading
>>registers when ending commands?  That is, unless there's some
>>noticeable performance impacts I'm not aware of.
> 
> 
> This would miss whole point of not _reading_ these registers (IO is slow).
> IMHO new flags denoting {in,out} registers should be added (to <linux/ata.h>
> to share them with libata) so new code can be sane and old flags would map
> on new flags when needed.

  Please do it.

  Or, let me know what you have in mind (added fields, flag names, 
etc...); then, I'll do it.  I think we also need to hear Jeff's opinion 
as things need to be added to ata.h.

  Thanks.

-- 
tejun

