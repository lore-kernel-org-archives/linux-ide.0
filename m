From: Tejun Heo <htejun@gmail.com>
Subject: Re: Early ATA devices
Date: Wed, 01 Aug 2007 15:02:36 +0900
Message-ID: <46B021FC.20507@gmail.com>
References: <20070801014137.4ab39e94@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:50482 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbXHAGCm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 02:02:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so85362rvb
        for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 23:02:41 -0700 (PDT)
In-Reply-To: <20070801014137.4ab39e94@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:
> So I've been doing a scan of the code versus the early ATA specifications
> (English translation not the original Latin ;))
> 
> I've found a couple of problem cases we don't deal with but I'm not sure
> matter, and an inconsistency
> 
> #1	We assume identify works. Early ATA actually lists this command
> as optional
> #2	We don't allow for INIT_DEV_PARAMS failing which it may do on
> some early IDE pre ATA devices
> 
> and the inconsistency
> 
> We check ATA < 4 || non-LBA capable when deciding whether to issue
> INIT_DEV_PARAMS. ATA 4+ however mandate LBA so the second case isn't
> theoretically at least possible.
> 
> Aside from those cases the command issue (but not the detection paths)
> appear to be clean for everything from ST412 upwards providing a drive is
> being used in 16 head mode and does its own write precompensation
> selection.
> 
> So in theory we can persuade libata to drive original MFM/RLL disks with
> relatively few changes

Does anyone have a working device to test?

-- 
tejun
