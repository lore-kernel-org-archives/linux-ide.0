From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] 2.6.x libata new PCI ids
Date: Mon, 23 May 2005 23:14:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505232310590.2307@ppc970.osdl.org>
References: <4292BA93.801@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fire.osdl.org ([65.172.181.4]:55784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261175AbVEXGMQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 May 2005 02:12:16 -0400
In-Reply-To: <4292BA93.801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>



On Tue, 24 May 2005, Jeff Garzik wrote:
>
> Please pull the 'new-ids' branch from
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> This add new PCI ids to some SATA drivers.

So here the trees are identical in between the two versions, so the later 
commit is definitely not doing anything. What's up?

I don't have a "git-undo" script, but it looks something like this:

	echo [top-you-want-to-save] > .git/HEAD
	git-read-tree -m HEAD
	git-update-cache -f -u -a

and you're done - it should take less than half a second.

You can do "git-prune-script" at some point if you want to throw away the
objects that are no longer reachable, but the way you work, you'll never 
even notice - you'll just have another stale head that isn't reachable 
from anywhere any more.

		Linus
----

commit 37c15447c565ab458ee3778e198d08f4041caa99
tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
parent 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
author Martin Povolny <martin.povolny@solnet.cz> Mon, 16 May 2005 02:41:00 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:41:00 -0400

[PATCH] sata_promise: new PCI ID for TX4200

[note - blank changeset]

--------------------------
commit 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
parent eeff84cc026e73d12fbe4484b5fa0d01efa8dc60
author Francisco Javier <ffelix@sshinf.com> Mon, 16 May 2005 02:39:00 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:39:00 -0400

[PATCH] sata_promise: add PCI ID for FastTrak TX2200 2-ports

