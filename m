From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] pata_amd: fix and improve cable detection
Date: Sat, 03 Nov 2007 07:22:16 +0900
Message-ID: <472BA318.7010406@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com>	<472B40B0.6010702@gmail.com> <20071102154406.7596b384@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:6660 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbXKBWWX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:22:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so910225rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:22:23 -0700 (PDT)
In-Reply-To: <20071102154406.7596b384@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> Cable detection on Nvidia PATA hosts is pathetic.  The current
>> nv_cable_detect() assumes that the native cable detection only
>> mistakes 80c as 40c but this isn't true.  On ASUS A8N-E, cable
>> register almost always says 80c is attached and it also manages to
>> trick the drive that the cable is 80c.
> 
> According to the last Nvidia comments on Nvidia there is no cable detect
> bit. I've just never gotten around to implementing it because due to lack
> of documentation Nvidia PATA is very very low priority compared to
> problems with documented chipsets from helpful vendors.

Yeah, it seems some boards just say 80C while others just say 40C, so
all we can use is how the BIOS configured it.  I suppose BIOS does it by
issuing trial commands which I don't think adding to libata is a good idea.

Can you please lemme know what you don't like about the current
implementation or what other approach you have in mind?  I don't like
Nvidia PATA either but there are a lot of people using it out there.

Thanks.

-- 
tejun
