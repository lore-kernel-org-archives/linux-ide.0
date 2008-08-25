From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE OOPS w/udevtrigger
Date: Mon, 25 Aug 2008 22:50:47 +0200
Message-ID: <200808252250.47719.bzolnier@gmail.com>
References: <20080825185224.GA5187@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:59683 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbYHYUxb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 16:53:31 -0400
Received: by gv-out-0910.google.com with SMTP id e6so367987gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 13:53:29 -0700 (PDT)
In-Reply-To: <20080825185224.GA5187@nineveh.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joseph Fannin <jfannin@gmail.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Monday 25 August 2008, Joseph Fannin wrote:

[...]

> So:  the ide hardware is known to be bad, and ide-generic is
> necessarily a bit blind, as I understand it... but the OOPS is new,
> and it seems like ide-generic isn't cleaning up after itself they way
> it did before.  Or maybe sysfs isn't.

Recent ide-generic fix from Borislav (to not probe automatically IDE PCI
hardware) should alleviate the first problem (it is in pata tree and in
linux-next):

http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-generic-handle-probing-of-legacy-io-ports-v5.patch
 
The sysfs OOPS (which should also be alleviated by the above fix)
is a bit more worrisome as it may hide some new bug.

> I'm willing to try to bisect this, but maybe it's not necessary?

If it is not too much work, please do (from the description of the
issue it seems it can be scripted into 'git bisect run' nicely).

Thanks,
Bart
