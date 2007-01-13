From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Sat, 13 Jan 2007 11:19:50 +0900
Message-ID: <45A841C6.9020207@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <200612191800.18624.kovid@theory.caltech.edu> <45889C67.900@gmail.com> <200701111532.03235.kovid@theory.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:37598 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161195AbXAMCT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 21:19:56 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1009094wxd
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 18:19:56 -0800 (PST)
In-Reply-To: <200701111532.03235.kovid@theory.caltech.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kovid Goyal <kovid@theory.caltech.edu>
Cc: linux-ide@vger.kernel.org

Kovid Goyal wrote:
> ata3: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
> ata4: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
> scsi2 : ata_piix
> scsi3 : ata_piix

Hmmm... ata3.00 was /dev/sda1.  Presence testing seems to have failed.
Please give a shot at 2.6.20-rc4.  We dropped whole presence detection
thing and went back to polling IDENTIFY and that fixed a lot of
detection bugs.  I think your problem is one of those.

Thanks.

-- 
tejun
