From: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 00:17:06 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040830221706.GA31968@bitwizard.nl>
References: <20040830163931.GA4295@bitwizard.nl> <20040830174632.GA21419@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from users.linvision.com ([62.58.92.114]:1418 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264530AbUH3WRJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2004 18:17:09 -0400
Content-Disposition: inline
In-Reply-To: <20040830174632.GA21419@thunk.org>
List-Id: linux-ide@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Aug 30, 2004 at 01:46:32PM -0400, Theodore Ts'o wrote:
> > a filesystem: if we recover one block this way, the next block will be
> > errorred and the filesystem "crashes" anyway. In fact this behaviour
> > may masquerade the first warnings that something is going wrong....
> 
> If the block gets successfully read after 2 or 3 tries, it might be a
> good idea for the kernel to automatically do a forced rewrite of the
> block, which should cause the disk to do its own disk block
> sparing/reassignment.  

Hi Ted, 

I agree that this is the theory. In practise however, I've never
seen it work correctly. We've seen several disks with say 1-5 bad
blocks and nothing else, and "dd if=/dev/zero of=/dev/<disk>" doesn't
seem to cure them.

	Roger. 

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!
