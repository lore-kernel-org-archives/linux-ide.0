From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] When a disk needs to be waken up from sleep, ensure that
	the command is retried by SCSI EH.
Date: Fri, 7 Aug 2009 15:19:08 -0700
Message-ID: <e7510f760908071519m3bb8f120s485f8a0dd0d2259f@mail.gmail.com>
References: <1249579547-21091-1-git-send-email-gwendal@google.com>
	 <e7510f760908061028o1b005c4wd2552c24fc619d9e@mail.gmail.com>
	 <4A7BE703.3000004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:2665 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZHGWTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 18:19:13 -0400
Received: from spaceape24.eur.corp.google.com (spaceape24.eur.corp.google.com [172.28.16.76])
	by smtp-out.google.com with ESMTP id n77MJBYW004054
	for <linux-ide@vger.kernel.org>; Fri, 7 Aug 2009 23:19:11 +0100
Received: from bwz22 (bwz22.prod.google.com [10.188.26.22])
	by spaceape24.eur.corp.google.com with ESMTP id n77MJ8Oi011694
	for <linux-ide@vger.kernel.org>; Fri, 7 Aug 2009 15:19:09 -0700
Received: by bwz22 with SMTP id 22so1651191bwz.18
        for <linux-ide@vger.kernel.org>; Fri, 07 Aug 2009 15:19:08 -0700 (PDT)
In-Reply-To: <4A7BE703.3000004@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

ATA_QCFLAG_RETRY is already set [by _autopsy()], ata_eh_qc_retry() was
already called, but given retries is 0, we can not reduce it.
However, I will submit a better patch, in ata_eh_qc_retry().

Gwendal.

On Fri, Aug 7, 2009 at 1:34 AM, Tejun Heo<tj@kernel.org> wrote:
> Gwendal Grignou wrote:
>> The explanation did not go through git-send-email:
>>
>> =A0Without this fix, ATA passthrough commands are not resend to the
>> drive, and no error is
>> =A0signalled to the caller because:
>> =A0- allowed retry count is 1
>> =A0- ata_eh_qc_complete fill the sense data, so result is valid
My mistake: __ata_eh_qc_complete() instead of ata_eh_qc_complete().
>> =A0- sense data is filled with untouched ATA registers.
>
> Would setting ATA_QCFLAG_RETRY achieve the same result?
>
> Thanks.
>
> --
> tejun
>
