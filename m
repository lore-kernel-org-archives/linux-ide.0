From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 20 Dec 2006 11:13:59 +0900
Message-ID: <45889C67.900@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <200612191800.18624.kovid@theory.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:28652 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964776AbWLTCOM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 21:14:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2040051uga
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 18:14:11 -0800 (PST)
In-Reply-To: <200612191800.18624.kovid@theory.caltech.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kovid Goyal <kovid@theory.caltech.edu>
Cc: linux-ide@vger.kernel.org

Kovid Goyal wrote:
> Yes going back to 2.6.17 does fix it. Also windows and various LiveCDs boot 
> without problems. 
> 
> Here is the output 
> smartctl -d ata -a /dev/sda
> smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/

Thanks, I couldn't find anything indicating hardware problem from the
smartctl output.  Ergh... The 0xff timing out is fixed in the devel
tree.  The problem is why sda sometimes doesn't get detected.  Can you
post the result of failing dmesg?  If you've got a second computer,
doing netconsole (Documentation/networking/netconsole.txt) is the best
way.  If not, just take a picture of the screen while ata1 detection is
in progress.

-- 
tejun
