From: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Subject: new regression in 2.6.25-rc3: can't resume from suspend to ram, ata1 errors
Date: Mon, 25 Feb 2008 22:57:24 +0200
Message-ID: <8f53421d0802251257o75d2975dldcfb99a2dc5e3539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:38632 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbYBYU50 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 15:57:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so963783ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 25 Feb 2008 12:57:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Jeff Garzik <jeff@garzik.org>j

On my T61p, 2.6.25-rc2 seems to wake up fine from suspend to ram.
Not so 2.6.25-rc3: it hangs on suspend to ram, with a blank screen.

At one point I got lucky and got this on console (wrote down by hand,
there could be typos):
ata1: COMRESET failed (errno=-16)
ata1: COMRESET failed (errno=-16)
end_request: I/O error, dev sda sector 200554
Buffer I/O error on device dm-0, logical block 256
Buffer I/O error on device dm-0, logical block 15695875
Buffer I/O error on device dm-0, logical block 15695878
Buffer I/O error on device dm-0, logical block 15695887
Buffer I/O error on device dm-0, logical block 15695896
Buffer I/O error on device dm-0, logical block 15695914
Buffer I/O error on device dm-0, logical block 15958028
Buffer I/O error on device dm-0, logical block 22118530
Buffer I/O error on device dm-0, logical block 22315068
Buffer I/O error on device dm-0, logical block 22347824

git bisect points at this commit:
commit 559bbe6cbd0d8c68d40076a5f7dc98e3bf5864b2.
power_state: get rid of write-only variable in SATA

After reverting 559bbe6cbd0d8c68d40076a5f7dc98e3bf5864b2
on top of 2.6.25-rc3 the kernel again resumes from suspend to ram.
