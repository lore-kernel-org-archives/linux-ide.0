From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use ARRAY_SIZE in ide-cd.c
Date: Sat, 28 Jul 2007 13:51:20 +0200
Message-ID: <200707281351.20491.bzolnier@gmail.com>
References: <20070727181039.GC24098@hindley.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:33777 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbXG1Lwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 07:52:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so80871nfb
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 04:52:53 -0700 (PDT)
In-Reply-To: <20070727181039.GC24098@hindley.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hindley <mark@hindley.org.uk>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


Hi,

On Friday 27 July 2007, Mark Hindley wrote:
> Hi,
> 
> ARY_LEN in ide-cd.{c,h} is an unnecessary duplication. Replace with generic ARRAY_SIZE from
> kernel.h.

Seems to be already fixed by:

commit 74c8f97a6c2d12fb144ad34076e969e8a01dc4b3
Author: Robert P. J. Day <rpjday@mindspring.com>
Date:   Mon Jul 9 23:17:57 2007 +0200

    ide-cd: replace C code with call to ARRAY_SIZE() macro

    Delete the unnecessary macro ARY_LEN and use ARRAY_SIZE directly.

    Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Please always make sure that you are working on the current git tree
or such unfortunate situation is likely to happen... ;)

Thanks,
Bart
