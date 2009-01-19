From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6] Hibernation/poweroff quirks (was: Re: [git patches] libata hibernation fixes)
Date: Mon, 19 Jan 2009 20:53:49 +0100
Message-ID: <200901192053.50831.rjw@sisk.pl>
References: <20081104062734.GA4420@havoc.gtf.org> <200901182125.04060.rjw@sisk.pl> <49739371.5030107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39378 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbZASUAw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 15:00:52 -0500
In-Reply-To: <49739371.5030107@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Frans Pop <elendil@planet.nl>, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 18 January 2009, Jeff Garzik wrote:
> Rafael J. Wysocki wrote:
> > On Sunday 18 January 2009, Frans Pop wrote:
> >> Rafael J. Wysocki wrote:
> >>> There is a name conflict with a change applied after this patchset had
> >>> been created.  The appended patch fixes it for me.
> >> [...]
> >>> @@ -483,7 +483,7 @@ const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list)
> >>>         const struct dmi_system_id *d; 
> >>>
> >>>         for (d = list; d->ident; d++)
> >>> -               if (dmi_match(d))
> >>> +               if (dmi_matches(d))
> >>>                         return d;
> >> I get two warnings when compiling your patch with this correction on top:
> > 
> > Hm, there were more patches than one, so I'm not sure.  When I apply all of
> > them, I don't see these error, but perhaps I should resend the entire series.
> > Will do tomorrow.
> 
> That would be useful...  I was planning to regenerate the series, but 
> this would save time.

The rebased series follows.

Thanks,
Rafael

