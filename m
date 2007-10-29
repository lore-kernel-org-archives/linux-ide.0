From: Tejun Heo <htejun@gmail.com>
Subject: Re: Re-enabling Serial ATA ports possible?
Date: Mon, 29 Oct 2007 12:22:01 +0900
Message-ID: <472551D9.8050908@gmail.com>
References: <200710171251.l9HCpCv7021811@harpo.it.uu.se> <200710261118.47736.openembedded@haerwu.biz> <4721B7EB.7010209@gmail.com> <200710261451.17154.openembedded@haerwu.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:7988 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbXJ2DWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 23:22:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1934869wah
        for <linux-ide@vger.kernel.org>; Sun, 28 Oct 2007 20:22:10 -0700 (PDT)
In-Reply-To: <200710261451.17154.openembedded@haerwu.biz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcin Juszkiewicz <openembedded@haerwu.biz>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Marcin Juszkiewicz wrote:
> This time it worked (log below). Should I check power supply and replace
> it if needed?
> 
> [ 6760.345046] ata6: exception Emask 0x10 SAct 0x0 SErr 0x90000 action 0xb
> [ 6760.345053] ata6: SError: { PHYRdyChg 10B8B }

Okay, this is PHYRDY changed w/o any command pending.  Things like this
happening autonomously indicates something is off with your hardware.  I
can't tell which.  It could be PSU, the controller or the drive itself.
 The only way to find out is trying different hardware configurations
and examining how the symptom changes.  ie. connecting the drive to
another port or controller, trying different power supply, etc...

-- 
tejun
