From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bug? ahci.c
Date: Wed, 28 Feb 2007 01:05:24 +0900
Message-ID: <45E456C4.1050102@gmail.com>
References: <45B0B7C6.3030206@qmul.ac.uk> <45E44C26.2010207@gmail.com> <45E45495.2020800@qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:32117 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933071AbXB0QF0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 11:05:26 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1739130wxd
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 08:05:25 -0800 (PST)
In-Reply-To: <45E45495.2020800@qmul.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Ray <j.ray@qmul.ac.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

James Ray wrote:
> I managed to get a response from Jeff on the linux-kernel list which I
> have yet to respond to (sorry!).
> 
> This problem was fixed by dodgy NCQ on the disk itself, S/N:
> WMANM2828677 P/N: WD1600JS-60MHB1 (Western Digital 160Gb). If I disabled
> the disk it worked fine, or replaced the disks with Some Seagates it
> worked fine also!
> 
> I am running a 2.6.19 at the moment quite happily. Still want me to test
> a 2.6.20.1? I might be able to get a bit of time later on this week.

Nope, as long as you're happy.  :-)

-- 
tejun
