From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 16:07:25 -0600
Message-ID: <46F9869D.60401@gmail.com>
References: <46F7FBCB.4030803@gmail.com> <46F8665A.4000206@garzik.org> <46F9617F.1010508@gmail.com> <46F97257.3020502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:6902 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbXIYWHe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 18:07:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1827567rvb
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 15:07:33 -0700 (PDT)
In-Reply-To: <46F97257.3020502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Jeff Garzik wrote:
> Can you tell me something about this device?
> 
> [   49.045635] ata2.00: ATA-6: Config  Disk, RGL10364, max UDMA/133
> [   49.051677] ata2.00: 640 sectors, multi 1: LBA
> [   49.056321] ata2.00: configured for UDMA/133
> 
> It seems like it does not support the 'check power mode' command.
> 
> Can you post a text file attachment, containing the output of 'hdparm
> --Istdout' ?

No problem.  The device in question is a Western Digital Raptor WD360GD
36.7GB 10,000 RPM Serial ATA150 Hard Drive.

hdparm output attached.

Berck
