From: Frans Pop <elendil@planet.nl>
Subject: Re: kernel BUG at drivers/ide/ide-disk.c:187 (2.6.31)
Date: Thu, 1 Oct 2009 10:26:14 +0200
Message-ID: <200910011026.17510.elendil@planet.nl>
References: <20090930110529.GA3676@dis.manty.net> <20090930110529.GA3676@dis.manty.net> <20090930235709.43ff1255.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:56601 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755980AbZJAI0P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Oct 2009 04:26:15 -0400
In-reply-To: <20090930235709.43ff1255.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: manty@manty.net
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi Manty,

Andrew Morton wrote:
> On Wed, 30 Sep 2009 13:05:29 +0200 Santiago Garcia Mantinan wrote:
>> kernel BUG at drivers/ide/ide-disk.c:187!

Looks like this is a deliberate test for unknown requests that was added in 
2.6.31 with the following commit:

commit 2c7eaa43c3bb7b3b9fe2051d17f308c1f0728c78
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Mon Jun 15 22:16:10 2009 +0200

    ide: BUG() on unknown requests

    Unsupported requests should be never handed down to device drivers
    and the best thing we can do upon discovering such request inside
    driver's ->do_request method is to just BUG().

In previous kernels the code would not dump, but still fail and print the 
request flags, identified by "ide_do_rw_disk - bad command", to the kernel 
log.
Manty: Have you ever seen such messages with previous kernels?

Question for IDE maintainers: should maybe the old printing of request info 
be reinstated, or can the request flags also be obtained from the BUG 
info?

Cheers,
FJP
