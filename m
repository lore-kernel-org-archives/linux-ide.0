From: David Miller <davem@davemloft.net>
Subject: Re: recent IDE regression
Date: Sat, 26 Jul 2008 17:31:43 -0700 (PDT)
Message-ID: <20080726.173143.137065135.davem@davemloft.net>
References: <20080724.233831.193691312.davem@davemloft.net>
	<200807261404.49947.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758033AbYG0Abx@vger.kernel.org>
In-Reply-To: <200807261404.49947.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: harvey.harrison@gmail.com, linux-ide@kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Sat, 26 Jul 2008 14:04:49 +0200

> PS We need more big-endian users testing linux-next (this particular patch
> despite being trivial has been put there just-in-case for a week)

Normally I do test linux-next from time to time.

But in the past week or so my efforts have been purely focused on
merging the tree(s) that I maintain.

It's going to be like this for bascially every other person doing
development.

Therefore I would suggest not adding changes during the merge window
that you or someone else has not actually tested.
