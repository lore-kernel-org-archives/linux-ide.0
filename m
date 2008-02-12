From: Tejun Heo <htejun@gmail.com>
Subject: How to verify sht-ops-conversion patch doesn't change anything
Date: Tue, 12 Feb 2008 22:25:54 +0900
Message-ID: <47B19E62.9030601@gmail.com>
References: <1202805801343-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:55077 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181AbYBLN0D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 08:26:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2769747wah.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 05:26:01 -0800 (PST)
In-Reply-To: <1202805801343-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech

The fifth and sixth patch, cleanup-sht and cleanup-ops, can be
verified not to change the final sht and ops by printing out all
entries and comparing the values before and after.

1. Get the following git branch.

   http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops-verify-before
   git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git cleanup-sht-ops-verify-before

   Build the kernel with the libata modules to verify and run the
   following command.

   # insmod libata.ko; for i in $(ls *.ko | sort | grep -v libata.ko); do insmod $i; done; dmesg -c | grep -E 'SHT|OPS' | sed -r 's/^\[[ \.0-9]*\] (.*)$/\1/' | sort > ~/out.before

   If you need some libata modules built-in for rootfs, it's okay too.
   It will give the same result.

2. Get the following git branch.

   http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops-verify-after
   git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git cleanup-sht-ops-verify-after

   # insmod libata.ko; for i in $(ls *.ko | sort | grep -v libata.ko); do insmod $i; done; dmesg -c | grep -E 'SHT|OPS' | sed -r 's/^\[[ \.0-9]*\] (.*)$/\1/' | sort > ~/out.after

3. Use your favorite diff program to compare out.before and out.after.
   Graphical ones which show in-line differences will work best.

Thanks.

-- 
tejun
