From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix init/performance regression ?
Date: Mon, 10 Dec 2007 18:47:38 +0900
Message-ID: <475D0B3A.7000406@gmail.com>
References: <32463620@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:61876 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbXLJJrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 04:47:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3248508wah
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 01:47:44 -0800 (PST)
In-Reply-To: <32463620@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devzero@web.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

devzero@web.de wrote:
> Hello !
> 
> on my old fujitsu-siemens lifebook, booting is at least 20 seconds slower as before.
> 
> on ata_piix init i can see 2 longer delays of ~10 seconds each, which didn`t happen before.
> 
> i`m using SuSE kernel of the day from http://ftp.suse.com/pub/projects/kernel/kotd/
> 
> problem exists with these kernels:
> kernel-vanilla-2.6.24_rc3_git3-20071201095839
> kernel-default-2.6.24_rc3_git3-20071201095839
> kernel-default-2.6.24_rc4_git3-20071206172629
> kernel-vanilla-2.6.24_rc4_git3-20071206172629
> 
> problem didn`t exist with this one:
> kernel-default-2.6.22.12-0.1 (opensuse 10.3 default)
> 
> please see https://bugzilla.novell.com/show_bug.cgi?id=345442 for more details.

That's a TSC problem on suse kernel.  I'll follow up on the bugzilla.

-- 
tejun
