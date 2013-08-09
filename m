From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 9 Aug 2013 10:03:58 -0400
Message-ID: <20130809140358.GA20515@mtj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55815 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018Ab3HIOEE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 10:04:04 -0400
Received: by mail-qc0-f172.google.com with SMTP id a1so2226484qcx.3
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 07:04:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

On Thu, Aug 08, 2013 at 09:49:10PM -0700, Marc C wrote:
> From: Marc Carino <marc.ceeeee@gmail.com>
> 
> SATA 3.1 added an "auxiliary" field to the host-to-device FIS.
> 
> Since there is no analog between the new field and the ATA
> taskfile, a new element was added to 'struct ata_queued_cmd."

Ummm... I'm sorry but I'm gonna do 180 from Sergei on this one.  The
auxiliary field is part of ata taskfile for all intents and purposes.
FIS is the new command structure anyway and struct ata_taskfile proper
should be able to describe the command with ata_queuedcmd providing
the surrounding context.  The argument that ata_taskfile shouldn't
contain anything which wasn't in PATA taskfile is bogus as it already
contains ATA_TFLAG_*.

So, please put the aux field into ata_taskfile.  That's where it
belongs.

Thanks.

-- 
tejun
