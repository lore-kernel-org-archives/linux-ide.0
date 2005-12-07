From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 09:17:31 +0100
Message-ID: <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:17732 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750721AbVLGIRd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 03:17:33 -0500
Received: by nproxy.gmail.com with SMTP id x29so88731nfb
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2005 00:17:32 -0800 (PST)
In-Reply-To: <20051206222001.GA14171@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On 12/6/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Dec 06, 2005 at 02:10:04PM +0800, Shaohua Li wrote:
>
> > TODO: invoking ATA commands.
> >
> > Though we didn't invoke ATA commands, this patch fixes the bug at
> > http://bugzilla.kernel.org/show_bug.cgi?id=5604. And Matthew said this
> > actually fixes a lot of systems in his test.
> > I'm not familiar with IDE, so comments/suggestions are welcome.
>
> Of the DSDTs I've looked at, most seem to provide taskfile commands
> concerned about doing things like setting up drive security. I haven't
> yet seen an IDE failure on resume when using this patch, so the _GTF
> stuff doesn't seem terribly important. The reason for it not currently
> being implemented is that the IDE queues haven't been restarted at the
> point where this code is called, so there's no obvious way of submitting
> them to the drive yet.

Isn't ide-io.c:ide_{start,complete}_power_step() enough?

BTW:

bugzilla bug #5604 - user is using 'ide-generic' host driver instead
of 'piix' so no wonder that suspend/resume doesn't work

bugzilla bug #2039 - is probably fixed by 2.6.12 (contains bugfix for
via82cxxx host driver not  bugfix for not restoring transfer mode)

"From Matthew Garrett  2005-03-30 17:17 UTC  [reply] -------

Linux currently has no real support for setting up IDE interfaces on resume.
Some machines are kind enough to set the IDE interface up themselves, but on
others we're doomed to failure. I'm looking into implementing this, but it won't
happen until some time after Hoary."

ide_{start,complete}_power_step() was there since the early 2.6.x days

Bartlomiej
