From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/4] libata: implement ata_exec_internal()
Date: Tue, 13 Dec 2005 14:06:41 +0900
Message-ID: <439E56E1.1070109@gmail.com>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com> <20051211042303.GA29403@htj.dyndns.org> <439E54F8.8020304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:32378 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbVLMFG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 00:06:57 -0500
Received: by zproxy.gmail.com with SMTP id 13so669735nzn
        for <linux-ide@vger.kernel.org>; Mon, 12 Dec 2005 21:06:56 -0800 (PST)
In-Reply-To: <439E54F8.8020304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> This patch implements ata_exec_internal() function which performs
>> libata internal command execution.  Previously, this was done by each
>> user by manually initializing a qc, issueing it, waiting for its
>> completion and handling errors.  In addition to obvious code
>> factoring, using ata_exec_internal() fixes the following bugs.
>>
>> * qc not freed on issue failure
>> * ap->qactive clearing could race with the next internal command
>> * race between timeout handling and irq
>> * ignoring error condition not represented in tf->status
>>
>> Also, qc & hardware are not accessed anymore once it's completed,
>> making internal commands more conformant with general semantics.
>> ata_exec_internal() also makes it easy to issue internal commands from
>> multiple threads if that becomes necessary.
>>
>> This patch only implements ata_exec_internal().  A following patch
>> will convert all users.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> I ACK this version of the patchset, patches 1-4, but they don't seem to 
> apply to 'upstream' branch:
> 
> [jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
> 4 patch(es) to process.
> 
> Applying 'libata: implement ata_exec_internal()'
> 
> error: patch failed: include/linux/libata.h:136
> error: include/linux/libata.h: patch does not apply
> 

Oh... Sorry, all patches are against the ALL branch.  Do you want me to 
regenerate them against upstream?

Also, I'm currently working on a series of EH improvement patches 
against the ALL branch.  Would generating patches against upstream be 
better?

Thanks.

-- 
tejun
