From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 09 Aug 2013 19:06:35 -0700
Message-ID: <5205A02B.6010208@gmail.com>
References: <52059FBF.7050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41135 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031731Ab3HJCGl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 22:06:41 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so1229480pdj.31
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 19:06:41 -0700 (PDT)
Received: from [192.168.1.15] (ip68-231-212-75.oc.oc.cox.net. [68.231.212.75])
        by mx.google.com with ESMTPSA id e7sm22907794pbc.11.2013.08.09.19.06.39
        for <linux-ide@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 19:06:40 -0700 (PDT)
In-Reply-To: <52059FBF.7050303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,
> The auxiliary field is part of ata taskfile for all intents and purposes.
> FIS is the new command structure anyway and struct ata_taskfile proper
> should be able to describe the command with ata_queuedcmd providing
> the surrounding context.  The argument that ata_taskfile shouldn't
> contain anything which wasn't in PATA taskfile is bogus as it already
> contains ATA_TFLAG_*.
>     That's what make 'struct ata_taskfile' bogus. I'm going to remove 
> 'protocol', 'flags', and 'ctl' fields from there (at least to save a space in 
> 'struct ata_queued_cmd' because they're not used in 'result_tf').
>
>> So, please put the aux field into ata_taskfile.  That's where it
>> belongs.
>     Can't agree to that. I was going to make 'struct ata_taskfile' reflect the 
> historical notion and remove from it all not belonging to that notion. Alas, 
> libata has a bad history of mistreating the historical terms...

While I understand that some non-spec items don't belong in the taskfile struct (and should/will be cleaned up), I have to agree with Tejun regarding how the auxiliary field should be put in 'struct ata_taskfile'. If anything, the struct should represent ALL items that an ATA command will use as inputs. As of now, it's the stuff that's currently in the taskfile + this pesky new 'auxiliary' entry. (FYI, ATA-8 ACS refers to these items as"fields.")

>From what I can tell, there are a couple of places where a rigid definition of a taskfile truly matters, and that's:

1) SCSI to ATA passthrough
2) PATA

But in any event, sticking 'auxiliary' in doesn't matter from a compatibility standpoint, since only NCQ commands use the new field, and the above can't transport NCQ (yet in (1) case).

Tejun put it succinctly by stating:

> I mean, FIS is the new TF.  We can rename ata_taskfile to
> ata_fis and map things the other way but that'd just be extra churn.

Ideally this would be the case, since the SATA FIS is a super-set of any/all fields defined in all ATA commands.

Regards,
Marc



