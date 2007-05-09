From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possible Bug in sata_via when trying to burn
Date: Wed, 09 May 2007 15:50:38 +0200
Message-ID: <4641D1AE.3070602@gmail.com>
References: <46419A8B.2060605@ds.gauner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:18899 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577AbXEINur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 09:50:47 -0400
Received: by py-out-1112.google.com with SMTP id a29so163221pyi
        for <linux-ide@vger.kernel.org>; Wed, 09 May 2007 06:50:47 -0700 (PDT)
In-Reply-To: <46419A8B.2060605@ds.gauner.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominik Schulz <lkml@ds.gauner.org>
Cc: linux-ide@vger.kernel.org

Hello, Dominik.

Dominik Schulz wrote:
> The Problem seems to affect cd writers attached to this chip, sata as
> well as pata [2].
> 
> Some details of my system:
> Debian etch, running the 2.6.21 Kernel.
> The CD-Writer is a NEC ND-3500AG attachted to the PATA Port of the VIA
> 6421 Chip on an Abit AX8 V2.0 Motherboard.
> lspci -vvv is at [3]
> dmesg at [4]
> the wodim output when trying to blank a cd [5]
> kernel .config at [6]

I need more info to tell what's going on.

1. Does the kernel complain about anything during wodim runs?
2. Please run wodim with -VV and report what it says.

Thanks.

-- 
tejun
