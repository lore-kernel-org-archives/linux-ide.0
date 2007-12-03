From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-dev git question:
Date: Mon, 03 Dec 2007 13:33:16 +0900
Message-ID: <4753870C.3040204@gmail.com>
References: <4752C70F.80506@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020907030905050902080209"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:5867 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbXLCEdX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 23:33:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2532187rvb
        for <linux-ide@vger.kernel.org>; Sun, 02 Dec 2007 20:33:23 -0800 (PST)
In-Reply-To: <4752C70F.80506@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020907030905050902080209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Attached is the script I use to keep a tree synced with upstream tree.
.git/origin points to upstream repo like the following.

  master.kernel.org /pub/scm/linux/kernel/git/jgarzik/libata-dev.git ssh

If you have ssh access to the origin, specify ssh as above, everything
will go over a ssh channel.  If you don't, you need rsync and git access
to the machine.

The script keeps the tree heads identical to the upstream tree so don't
create custom branches in the tree.  They'll go away when you run
git-sync.sh the next time.  I have ~/os/linux-2.6 and
~/os/ata/work/libata-dev trees to track upstream and ~/os/work and
~/os/ata/work trees where I work on and fetches / pulls necessary heads
from the two upstream clones.

If you make your work trees' alternates files to point to the upstream
clones, having separate upstream and work trees don't waste much space
and it's easy to check what's going on upstream that way.

-- 
tejun

--------------020907030905050902080209
Content-Type: application/x-shellscript;
 name="git-sync.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-sync.sh"

IyEvYmluL3NoCgppZiBbICEgLXIgLmdpdC9vcmlnaW4gXTsgdGhlbgogICAgICAgIGVjaG8g
Im5vdCBpbiBnaXQgcmVwbyIgMj4mMQogICAgICAgIGV4aXQgMQpmaQoKb3JpZ2luPSgkKGNh
dCAuZ2l0L29yaWdpbikpCgpwcm90PXJzeW5jLGdpdApwcm90MD1yc3luYzovLwpwcm90MT1n
aXQ6Ly8Kc2VwPS8KaWYgWyAiJHtvcmlnaW5bMl19IiA9PSAic3NoIiBdOyB0aGVuCiAgICBw
cm90PXNzaAogICAgcHJvdDA9CiAgICBwcm90MT0KICAgIHNlcD06CmZpCgpwYXRoPSR7b3Jp
Z2luWzBdfSR7c2VwfSR7b3JpZ2luWzFdfQoKZWNobyAiWyAkcHJvdDovLyRwYXRoIF0iCgpy
bSAtcmYgLmdpdC90bXAtcmVmcy8KCmlmICEgcnN5bmMgLWF2eiAke3Byb3QwfSR7cGF0aH0v
cmVmcy8gLmdpdC90bXAtcmVmcy87IHRoZW4KCWVjaG8gInJzeW5jIG9mIHJlZnMgZmFpbGVk
IiAyPiYxCglleGl0IDEKZmkKCmFyZ3M9IiIKCmZvciBpIGluIC5naXQvdG1wLXJlZnMvaGVh
ZHMvKjsgZG8KCWJyYW5jaD0kKGJhc2VuYW1lICIkaSIpCglhcmdzKz0iICskYnJhbmNoOiRi
cmFuY2giCmRvbmUKCmlmICEgZ2l0LWZldGNoIC11IC1mICR7cHJvdDF9JHtwYXRofSAkYXJn
czsgdGhlbgoJZWNobyAiZ2l0LWZldGNoIGZhaWxlZCIgMj4mMQoJZXhpdCAxCmZpCgpybSAt
cmYgLmdpdC9vbGQtcmVmcwptdiAtZiAuZ2l0L3JlZnMgLmdpdC9vbGQtcmVmcwptdiAtZiAu
Z2l0L3RtcC1yZWZzIC5naXQvcmVmcwoK
--------------020907030905050902080209--
