From: Tejun Heo <htejun@gmail.com>
Subject: Re: SIlicon Image Controller 3512A or Seagate Barracuda ST3160827AS
 Issue
Date: Mon, 21 Jan 2008 17:31:39 +0900
Message-ID: <4794586B.7050706@gmail.com>
References: <4764b0290801192151h15405acahda1769621ba3b4cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:16420 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758106AbYAUIbo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 03:31:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3563811wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 00:31:44 -0800 (PST)
In-Reply-To: <4764b0290801192151h15405acahda1769621ba3b4cd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Mugan <tony@mugan.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tony Mugan wrote:
> Hello Jeff,
> 
> I've tried a few recent Kernels (incl 2.6.23.14) attempting to have my
> SATA Raid configuration detected to no avail.  My SATA drives are not
> on your blacklist in sata_sil.c so I decided to contact you to see if
> I am missing something or can offer a testbed to get this resolved.
> 
> I have found a kernel forum posting from you back in 2004 relating to
> an issue with a slightly different Sil controller but the same drives.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0535.html
> You refer to updates in firmware resolving Raid-related issues but I
> cannot find any updates beyond my current v3.42 for these drives.  Nor
> were there an newer Mobo firmwares beyond "FK" which I have installed.
> 
> I'd be grateful for any pointers and would be very interested in
> assisting where I can in providing information if possible.
> 
> I have attached some general information regarding my setup.

Please read the following page.

http://linux-ata.org/faq-sata-raid.html

BIOS RAIDs are supported via device mapper.  I dunno which format the
sil controller uses and whether dm supports it tho.  Unless you have to
use it for another OS, BIOS raids are usually worthless marketing crap.
 Just use software RAID (md).

Thanks.

-- 
tejun
