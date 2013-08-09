From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 09 Aug 2013 18:36:19 +0400
Message-ID: <5204FE63.4010903@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com> <20130809140358.GA20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40473 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030511Ab3HIOgL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:36:11 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so3264387lbc.13
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:36:10 -0700 (PDT)
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

    That's very unfortunate for me. :-(

> auxiliary field is part of ata taskfile for all intents and purposes.
> FIS is the new command structure anyway and struct ata_taskfile proper
> should be able to describe the command with ata_queuedcmd providing
> the surrounding context.  The argument that ata_taskfile shouldn't
> contain anything which wasn't in PATA taskfile is bogus as it already
> contains ATA_TFLAG_*.

    That's what make 'struct ata_taskfile' bogus. I'm going to remove 
'protocol', 'flags', and 'ctl' fields from there (at least to save a space in 
'struct ata_queued_cmd' because they're not used in 'result_tf').

> So, please put the aux field into ata_taskfile.  That's where it
> belongs.

    Can't agree to that. I was going to make 'struct ata_taskfile' reflect the 
historical notion and remove from it all not belonging to that notion. Alas, 
libata has a bad history of mistreating the historical terms...

> Thanks.

WBR, Sergei

