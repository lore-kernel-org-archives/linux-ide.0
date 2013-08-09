From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Sat, 10 Aug 2013 01:24:45 +0400
Message-ID: <52055E1D.6030809@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com> <20130809140358.GA20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:48882 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031121Ab3HIVYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 17:24:37 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so3386176lab.16
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 14:24:35 -0700 (PDT)
In-Reply-To: <20130809140358.GA20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

On 08/09/2013 06:03 PM, Tejun Heo wrote:

>> From: Marc Carino <marc.ceeeee@gmail.com>

>> SATA 3.1 added an "auxiliary" field to the host-to-device FIS.

>> Since there is no analog between the new field and the ATA
>> taskfile, a new element was added to 'struct ata_queued_cmd."

> Ummm... I'm sorry but I'm gonna do 180 from Sergei on this one.  The
> auxiliary field is part of ata taskfile for all intents and purposes.

    Which would be another abuse of the ATA taskfile term (reminds me of SFF 
abuse wehre everybody hushed me down saying that it's too late to change 
anything and for all intenets and purposes SFF means "taskfile based" for 
everybody). As Marc rightly said, this field won't be deliverable by the usual 
taskfile methods. Moreover, it won't be used in qc->result_tf' and so will 
waste 4 bytes for no reason.

> FIS is the new command structure anyway and struct ata_taskfile proper
> should be able to describe the command with ata_queuedcmd providing
> the surrounding context.

    It depends on your definition of surrounding context. In my definition, 
'flags' and 'protocol' fields should be a part of surrounding context. 'ctl' 
too sicen the device control register was never considered a part of the ATA 
taskfile and it's not used in 'qc->result_tf' (as well as the other two 
fields), hence just wasting memory for no reason.

> The argument that ata_taskfile shouldn't
> contain anything which wasn't in PATA taskfile is bogus as it already
> contains ATA_TFLAG_*.

    I regret that I haven't done my patches earlier to get rid of this example 
of abuse of the ATA taskfile before.

> So, please put the aux field into ata_taskfile.  That's where it
> belongs.

    Sigh.

> Thanks.

WBR, Sergei

