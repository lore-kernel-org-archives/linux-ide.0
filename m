From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH -next] ide: fix Makefile for ide-disk_proc
Date: Tue, 2 Sep 2008 20:47:38 +0200
Message-ID: <200809022047.38151.bzolnier@gmail.com>
References: <48BD89A6.1040200@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:8396 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbYIBSub (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 14:50:31 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1745029ugf.37
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 11:50:29 -0700 (PDT)
In-Reply-To: <48BD89A6.1040200@oracle.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-next@vger.kernel.org, akpm <akpm@linux-foundation.org>

On Tuesday 02 September 2008, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix ide-disk_proc build error due to 2 entries in Makefile, one of them
> being unconditional.
> 
> When CONFIG_IDE_PROC_FS=n, there are lots of errors/warnings:

Thanks but this was already fixed in pata tree
(http://lkml.org/lkml/2008/9/2/65).
