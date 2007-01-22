From: Tejun Heo <htejun@gmail.com>
Subject: Re: Reg. SATA II NCQ
Date: Mon, 22 Jan 2007 14:59:44 +0900
Message-ID: <45B452D0.8030704@gmail.com>
References: <e93ba0ce0701170058x30a7c31cr2ce291d3f8f89080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXAVGAn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 01:00:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so966148uga
        for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2007 22:00:42 -0800 (PST)
In-Reply-To: <e93ba0ce0701170058x30a7c31cr2ce291d3f8f89080@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaychander T <jaychander@gmail.com>
Cc: linux-ide@vger.kernel.org

Jaychander T wrote:
> I understand from the SATA II NCQ specs that for NCQ commands(FPDMA)
> we need not have to setup the DMA (PRD) for the commands issued but
> has to do

That's different thing.  NCQ protocol doesn't require DMA SETUP FIS 
which is required for normal DMA commands but the controller still needs 
to be prepped with DMA table to know from/to where transfer data.

> so only on reception of DMA setup FIS from the drive(throught ISR).
> But in libata/ ata_qc_issue does qc prep and issue irrespective of the
> protocol.

Yeap, DMA table needs to be prepped whether NCQ is used or not.

> Even i glanced thro' the sil24 driver and seems to be the same.

The same for sil24.

-- 
tejun
