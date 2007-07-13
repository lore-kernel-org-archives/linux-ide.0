From: David Shaw <dshaw@jabberwocky.com>
Subject: Re: Possible data corruption sata_sil24?
Date: Fri, 13 Jul 2007 07:59:19 -0400
Message-ID: <20070713115919.GC17811@jabberwocky.com>
References: <20070706012432.GB29789@jabberwocky.com> <4693A5A0.5070306@gmail.com> <20070713014252.GA17811@jabberwocky.com> <46972AEE.2040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from foobar.cs.jhu.edu ([128.220.13.173]:4619 "EHLO
	foobar.cs.jhu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbXGML70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 07:59:26 -0400
Received: from walrus.jabberwocky.com (c-75-67-134-120.hsd1.ma.comcast.net [75.67.134.120])
	by foobar.cs.jhu.edu (8.11.6/8.11.6) with ESMTP id l6DBxP801555
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 07:59:25 -0400
Received: from grover.jabberwocky.com (grover.jabberwocky.com [172.24.84.28])
	by walrus.jabberwocky.com (8.14.1/8.14.1) with ESMTP id l6DBxKIm014914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 07:59:20 -0400
Received: from grover.jabberwocky.com (localhost.localdomain [127.0.0.1])
	by grover.jabberwocky.com (8.13.8/8.13.8) with ESMTP id l6DBxKKG025992
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 07:59:20 -0400
Received: (from dshaw@localhost)
	by grover.jabberwocky.com (8.13.8/8.13.8/Submit) id l6DBxJjT025991
	for linux-ide@vger.kernel.org; Fri, 13 Jul 2007 07:59:19 -0400
Content-Disposition: inline
In-Reply-To: <46972AEE.2040805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, Jul 13, 2007 at 04:34:06PM +0900, Tejun Heo wrote:

> > It fails whether I use a raw /dev/sdd or partition it into one large
> > /dev/sdd1, or partition into multiple partitions.  sata_sil24 seems to
> > work by itself, as does dm, but as soon as I mix sata_sil24+dm, I get
> > corruption.
> 
> Hmmmm.... Can you reproduce the corruption by accessing both devices
> simultaneously without using dm?  Considering ich5 does fine, it looks
> like hardware and/or driver problem and I really wanna rule out dm.

I think I wasn't clear enough before.  The corruption happens when I
use dm to create two dm mappings that both reside on the same real
device.  Using two different devices, or two different partitions on
the same physical device works properly.  ich5 does fine with these 3
tests, but sata_sil24 fails:

 * /dev/sdd, create 2 dm linear mappings on it, mke2fs and use those
   dm "devices" == corruption

 * Partition /dev/sdd into /dev/sdd1 and /dev/sdd2, mke2fs and use
   those partitions == no corruption

 * Partition /dev/sdd into /dev/sdd1 and /dev/sdd2, create 2 dm linear
   mappings on /dev/sdd1, mke2fs and use those dm "devices" ==
   corruption

David
