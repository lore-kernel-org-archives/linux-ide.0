From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: "buggy cmd640" message followed by soft lockup
Date: Sat, 24 Nov 2007 20:07:51 +0100
Message-ID: <200711242007.52430.rjw@sisk.pl>
References: <200711222007.12497.elendil@planet.nl> <200711241904.13132.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33004 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbXKXStx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Nov 2007 13:49:53 -0500
In-Reply-To: <200711241904.13132.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Saturday, 24 of November 2007, Bartlomiej Zolnierkiewicz wrote:
[--snip--]
> Rafael, I see that you've filled a bug for this bugreport into kernel
> bugzilla tracker (one day after the bugreport):
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=9442
> 
> Since we try to address regressions with the highest priority in the
> IDE-land (and usually they get fixed quickly) I would strongly prefer to
> use bugzilla only for long-term bugs and avoid the needless bureaucracy.

As a rule, I put all of the reported regressions into the Bugzilla early.  You
are not required to use these entries for tracking the bugs, though.  If you
don't want to, just leave the entry as is and I'll close it when the fix is in
the Linus' tree.

> Therefore I kindly ask you to defer filling bugs for new bugreports for
> a week or two, and give us some time to react (and always ping me about
> the bugreport status before filling bugzilla entry).

Well, I thought you'd get an email from the Bugzilla, but of course I can notify
you directly about reported regressions related to IDE.

> The alternative solution would be that you fill all new bugreports but
> then please assign them to yourself and track their status (if after two
> weeks the problem is not fixed feel free to reassign bug to me).

I can do that, but please note that the bugs filed against IDE are assigned to
you automatically, so I'll have to reassign them to me (as I've just done with
this particular entry).  If you don't want them to be assigned to you at all,
please contact the Bugzilla administrators and ask them to change that.

Thanks,
Rafael
