From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.23-mm1
Date: Sat, 13 Oct 2007 06:55:03 -0400
Message-ID: <4710A407.3070000@garzik.org>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>	 <20071012140328.f82af8e8.kamezawa.hiroyu@jp.fujitsu.com>	 <20071011234202.2f15bb76.akpm@linux-foundation.org>	 <64bb37e0710120131y6b939951y74c50bd596b1d938@mail.gmail.com>	 <20071012013729.ada2127b.akpm@linux-foundation.org> <64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33938 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbXJMKzI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Oct 2007 06:55:08 -0400
In-Reply-To: <64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Torsten Kaiser wrote:
> On 10/12/07, Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Fri, 12 Oct 2007 10:31:42 +0200 "Torsten Kaiser" <just.for.lkml@googlemail.com> wrote:
>>> Oct 12 10:23:03 treogen smartd[6091]: Device: /dev/sdc, not found in
>>> smartd database.
>> hm.
>>
>>> Oct 12 10:23:03 treogen [  105.990000] WARNING: at
>>> drivers/ata/libata-core.c:5752 ata_qc_issue()
>> Let's cc linux-ide.
>>
>>> Oct 12 10:23:03 treogen [  105.990000]
>>> Oct 12 10:23:03 treogen [  105.990000] Call Trace:
>>> Oct 12 10:23:03 treogen [  105.990000]  [<ffffffff804442ef>]
>>> ata_qc_issue+0x47f/0x540
>>> Oct 12 10:23:03 treogen [  105.990000]  [<ffffffff80432e60>] scsi_done+0x0/0x20
>>> Oct 12 10:23:03 treogen [  105.990000]  [<ffffffff80449c80>]
>>> ata_scsi_flush_xlat+0x0/0x30

> Oct 13 07:46:48 treogen [   99.850000]
> Oct 13 07:46:48 treogen [   99.850000] ata3: EH in SWNCQ
> mode,QC:qc_active 0x3 sactive 0x1
> Oct 13 07:46:48 treogen [   99.850000] ata3: SWNCQ:qc_active 0x1
> defer_bits 0x0 last_issue_tag 0x0

The WARNING indicates that there is a SWNCQ bug in sata_nv.  Given that 
the problem appears when SYNCHRONIZE CACHE is being issued, I would 
guess that sata_nv is not properly handling non-queued commands.

NVIDIA CC'd.

This is a patch from libata-dev.git#nv-swncq (via #ALL).

	Jeff




