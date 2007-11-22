From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Lost interrupt with cmd 64x
Date: Thu, 22 Nov 2007 23:12:58 +0100
Message-ID: <200711222312.58589.bzolnier@gmail.com>
References: <BAY139-W374C1413B6CEBCB202A330A37D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:57109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbXKVWHW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409664ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:21 -0800 (PST)
In-Reply-To: <BAY139-W374C1413B6CEBCB202A330A37D0@phx.gbl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: linux-ide@vger.kernel.org


Hi,

This problem should have been already fixed by:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6183289cd4356b790c5eaa619020fb887ec0fa44

which was merged into 2.6.24-rc3.

Thanks,
Bart
