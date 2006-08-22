From: Tejun Heo <htejun@gmail.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Wed, 23 Aug 2006 01:41:31 +0900
Message-ID: <44EB33BB.4090101@gmail.com>
References: <44EB32E4.8080706@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:28009 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751390AbWHVQlh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 12:41:37 -0400
Received: by py-out-1112.google.com with SMTP id n25so3060991pyg
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 09:41:36 -0700 (PDT)
In-Reply-To: <44EB32E4.8080706@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-ide@vger.kernel.org, Deepak Saxena <dsaxena@mvista.com>

Kevin Hilman wrote:
> I have a Silicon Images 3112 PCI card on an XScale IXP425 platform.  The 
> card works well in a PC, but I haven't got it to work in on the ARM 
> platform.  On the PC, I see the cards BIOS executed and am guessing that 
> since this can't happen on the ARM, that's why things aren't working.
> 
> The card is at least detected on the ARM, and the driver tries to probe 
> for devices, but times out an moves on.
> 
> Before I debug this too deeply, I want to make sure this should work on 
> embedded boards, even without the BIOS execution.

sil3112 works fine w/o any BIOS initialization.

-- 
tejun
