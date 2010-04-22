From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] When a disk wakes up from sleep, ensure that the command
	is retried by SCSI EH.
Date: Thu, 22 Apr 2010 10:43:36 -0700
Message-ID: <v2ne7510f761004221043y4b92ab7csa96b5b45fb07ea6b@mail.gmail.com>
References: <4A7CB4D6.7020902@kernel.org>
	 <1249687069-31011-1-git-send-email-gwendal@google.com>
	 <4A7CB769.4040309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:26328 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0DVRnk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 13:43:40 -0400
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id o3MHhb8K027248
	for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 19:43:38 +0200
Received: from vws14 (vws14.prod.google.com [10.241.21.142])
	by wpaz17.hot.corp.google.com with ESMTP id o3MHgq0l007306
	for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 10:43:37 -0700
Received: by vws14 with SMTP id 14so30878vws.33
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 10:43:36 -0700 (PDT)
In-Reply-To: <4A7CB769.4040309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Just looking into 2.6.33 code, and I did not find this patch. Is there
anything I should do to have it merge?

Thanks,
Gwendal.

On Fri, Aug 7, 2009 at 4:23 PM, Tejun Heo <tj@kernel.org> wrote:
> Gwendal Grignou wrote:
>> Without this fix, ATA passthrough commands are not resend to the drive, and no
>> error is signalled to the caller because:
>> - allowed retry count is 1
>> - ata_eh_qc_complete fill the sense data, so result is valid
>> - sense data is filled with untouched ATA registers.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@google.com>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> --
> tejun
>
