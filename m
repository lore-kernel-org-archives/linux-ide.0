From: "Jaychander T" <jaychander@gmail.com>
Subject: Reg. SATA II NCQ
Date: Wed, 17 Jan 2007 14:28:11 +0530
Message-ID: <e93ba0ce0701170058x30a7c31cr2ce291d3f8f89080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:29037 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbXAQI6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 03:58:12 -0500
Received: by wr-out-0506.google.com with SMTP id 70so1922510wra
        for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 00:58:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I understand from the SATA II NCQ specs that for NCQ commands(FPDMA)
we need not have to setup the DMA (PRD) for the commands issued but
has to do
so only on reception of DMA setup FIS from the drive(throught ISR).
But in libata/ ata_qc_issue does qc prep and issue irrespective of the
protocol.

Even i glanced thro' the sil24 driver and seems to be the same.

Can someone please guide/ resolve this doubt.

Regards
Jaychander
