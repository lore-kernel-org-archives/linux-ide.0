From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH] libata: track spindown status and skip =?utf-8?b?c3BpbmRvd25fY29tcGF0?= if possible
Date: Tue, 15 May 2007 11:53:11 +0000 (UTC)
Message-ID: <loom.20070515T133840-438@post.gmane.org>
References: <46498B82.1030802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41398 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758782AbXEOLx2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 07:53:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hnval-0000Mh-Fh
	for linux-ide@vger.kernel.org; Tue, 15 May 2007 13:53:23 +0200
Received: from host202-185-dynamic.1-79-r.retail.telecomitalia.it ([79.1.185.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 13:53:23 +0200
Received: from ceztko by host202-185-dynamic.1-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 13:53:23 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:

> 
> Our assumption that most distros issue STANDBYNOW seems wrong.  The
> upstream sysvinit and thus many distros including gentoo and opensuse
> don't take any action for libata disks on spindown.  We can skip
> compat handling for these distros so that they don't need to update
> anything to take advantage of kernel-side shutdown.
>

Working around the workaround won't make confusion? Won't this break again
implementations that was actually issuing STANDBYNOW, assuming that they
actually exist? Only wondering, can't say for any init implementation in
particular.

