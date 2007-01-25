From: "Jaychander T" <jaychander@gmail.com>
Subject: Re: Reg. SATA II NCQ
Date: Thu, 25 Jan 2007 11:46:14 +0530
Message-ID: <e93ba0ce0701242216y49c4455ek10bbc2fcff174a7a@mail.gmail.com>
References: <e93ba0ce0701170058x30a7c31cr2ce291d3f8f89080@mail.gmail.com>
	 <45B452D0.8030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:23953 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965472AbXAYGQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 01:16:15 -0500
Received: by nz-out-0506.google.com with SMTP id s1so330712nze
        for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2007 22:16:14 -0800 (PST)
In-Reply-To: <45B452D0.8030704@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi

Further to the discussion, can you clarify the following is correct:

Sequence for Legacy DMA:
1. Prepare SG/PRD table (qc_prep)
2. Issue command, BMDMA setup and start (Starts DMA transfer) (qc_issue)
|Issue command|Start DMA| ISR command completion.

Sequence for FPDMA:
1. Prepare SG/ PRD table (qc_prep)
2. Issue commands (but dont start DMA)
3. On reception of DMA setup FIS start DMA according to tag value.
|Issue command| Issue command| Issue command|.... ISR(DMA setup FIS) |
Start DMA | ISR | Start DMA ...

Regards
Jaychander

On 1/22/07, Tejun Heo <htejun@gmail.com> wrote:
> Jaychander T wrote:
> > I understand from the SATA II NCQ specs that for NCQ commands(FPDMA)
> > we need not have to setup the DMA (PRD) for the commands issued but
> > has to do
>
> That's different thing.  NCQ protocol doesn't require DMA SETUP FIS
> which is required for normal DMA commands but the controller still needs
> to be prepped with DMA table to know from/to where transfer data.
>
> > so only on reception of DMA setup FIS from the drive(throught ISR).
> > But in libata/ ata_qc_issue does qc prep and issue irrespective of the
> > protocol.
>
> Yeap, DMA table needs to be prepped whether NCQ is used or not.
>
> > Even i glanced thro' the sil24 driver and seems to be the same.
>
> The same for sil24.
>
> --
> tejun
>
