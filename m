From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI support on Intel chipsets (confusion?)
Date: Sun, 03 Dec 2006 22:34:51 +0900
Message-ID: <4572D27B.3000909@gmail.com>
References: <45715381.80206@SystemDesignWorks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:853 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756890AbWLCNfD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 08:35:03 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1728560nze
        for <linux-ide@vger.kernel.org>; Sun, 03 Dec 2006 05:35:03 -0800 (PST)
In-Reply-To: <45715381.80206@SystemDesignWorks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wayne Sherman <Wayne@SystemDesignWorks.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Wayne Sherman wrote:
> So, does the kernel source code incorrectly indicate some of these
> chipsets are AHCI compatible?

Not really.  If the controller has PCI ID of 0x27c1, it's an ahci
controller.  Care to post full dmesg and the result of 'lspci -nn'?

-- 
tejun
