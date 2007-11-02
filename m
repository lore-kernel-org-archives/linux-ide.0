From: Tejun Heo <htejun@gmail.com>
Subject: Re: [smartmontools-support] Bug/Issue
Date: Fri, 02 Nov 2007 21:09:44 +0900
Message-ID: <472B1388.2060208@gmail.com>
References: <474362.56402.qm@web51305.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:55428 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbXKBMLq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 08:11:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so786132rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 05:11:46 -0700 (PDT)
In-Reply-To: <474362.56402.qm@web51305.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon@eHardcastle.com
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Jon.

Please don't top-post.

Jon Hardcastle wrote:
> Looking at the logs there is seconds(as in 2~5)
> literally between when the smartd kicks in on the sata
> and when it decides the drive isn't capable. I can
> tell you now it takes at least 10~15 seconds for the
> drive to spin up.. probably longer. I also know that
> when i run the test manually using smartctl it seems
> to work, and that when the scheduled test is run when
> the drives HAVENT spun down it also works.

Okay, please do the following.

1. Post /var/log/boot.msg or dmesg result right after boot.
2. Post the result of "lspci -nnv"
3. Post the results of "hdparm -I /dev/sdX" where sdX is one of th
problematic drives.
4. Run "hdparm -y /dev/sdX" to spin it down then issue SMART short test
manually.  If it fails the same way, post what smartd/smartctl says and
the result of dmesg after the failure.

Thanks.

-- 
tejun
