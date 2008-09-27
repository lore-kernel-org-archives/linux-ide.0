From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Multiple MSI, take 3
Date: Sat, 27 Sep 2008 13:04:52 -0600
Message-ID: <20080927190452.GQ27204@parisc-linux.org>
References: <20080711005719.GO14894@parisc-linux.org> <df9815e70809252230x4eef3e1ep40a02f101cb90a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:35896 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbYI0TFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 15:05:14 -0400
Content-Disposition: inline
In-Reply-To: <df9815e70809252230x4eef3e1ep40a02f101cb90a87@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jike Song <albcamus@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, grundler@parisc-linux.org, mingo@elte.hu, tglx@linutronix.de, jgarzik@pobox.com, linux-ide@vger.kernel.org, suresh.b.siddha@intel.com, benh@kernel.crashing.org, jbarnes@virtuousgeek.org, rdunlap@xenotime.net, mtk.manpages@gmail.com

On Fri, Sep 26, 2008 at 01:30:11PM +0800, Jike Song wrote:
> On Fri, Jul 11, 2008 at 8:57 AM, Matthew Wilcox <matthew@wil.cx> wrote:
> > Patchset available as a git tree from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/willy/misc.git multiple-msi
> > (multiple-msi-20080710 is this patch set in particular)
> >
> > Patches will be sent in reply to this message.
> 
> Hi Matthew, what's current state of this work? I pulled it into a
> newly created git branch and tried to rebase it upon the latest Linus
> tree, found that there are some merge conflicts.

The status is that I was working on it on the plane home from Plumbers
and didn't quite managed to get it working on x86-32 yet.  This is a
requirement from Ingo before he'll accept the x86-64 implementation.
I was hoping to work on it some more this week, but a combination of
being ill and having other things to work on (including a lot of patch
review) has meant that I have not had time to look at it.

I did start setting up to test again on Friday ... hopefully I'll have
time on Monday.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
