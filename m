From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 12/12] libata: implement EH fast drain
Date: Wed, 04 Jul 2007 00:09:42 +0900
Message-ID: <468A66B6.6090901@gmail.com>
References: <1183283618296-git-send-email-htejun@gmail.com> <468A5F2E.9020002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:5064 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbXGCPJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 11:09:47 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1247233nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 08:09:46 -0700 (PDT)
In-Reply-To: <468A5F2E.9020002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> In most cases, when EH is scheduled, all in-flight commands are
>> aborted causing EH to kick in immediately.  However, in some cases
>> (especially with PMP), it's unclear which commands are affected by the
>> error condition and although aborting all in-flight commands work, it
>> isn't optimal and may cause unnecessary disruption.  On the other
>> hand, waiting for in-flight commands to drain themselves can take up
>> to 30seconds.
>>
>> This patch implements EH fast drain to handle such situations.  It
>> gives in-flight commands some time to finish up but doesn't wait for
>> too long.  After EH is scheduled, fast drain timer is started and if
>> no other completion occurs in ATA_EH_FASTDRAIN_INTERVAL all in-flight
>> commands are aborted.  If any completion occurred in the interval, the
>> port is given another interval to finish up itself.
>>
>> Currently ATA_EH_FASTDRAIN_INTERVAL is 3 secs which should be enough
>> for finishing up most commands.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> what type of errors are we talking about?  device errors can be handled
> on a more granular basis than other errors.

On standalone (non-PMP) port, this doesn't matter because in-flight
commands are always aborted when error occurs.  Fast drain helps when
PMP is involved.  For example, after certain event, PMP can notify host
that something is off via SDB notify but until EH kicks in and performs
autopsy, there's no way to tell to which port the event happened.

If there were in-flight commands to the failed link and/or PMP chip went
for lunch after the event (it often does), EH is forced to wait for
timeout even though it knows something is off.  Fast drain helps in such
situations - ie. when EH knows something wrong is going on and it's very
likely that commands which aren't completing are going to timeout.

-- 
tejun
