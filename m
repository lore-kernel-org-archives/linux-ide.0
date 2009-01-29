From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Thu, 29 Jan 2009 15:51:08 +0100
Message-ID: <200901291551.09238.rjw@sisk.pl>
References: <20081104062734.GA4420@havoc.gtf.org> <200901192054.55536.rjw@sisk.pl> <20090129130435.GB1425@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43357 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbZA2Ov3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 09:51:29 -0500
In-Reply-To: <20090129130435.GB1425@ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <jeff@garzik.org>, Frans Pop <elendil@planet.nl>, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 29 January 2009, Pavel Machek wrote:
> On Mon 2009-01-19 20:54:54, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce boolean function system_entering_hibernation() returning
> > 'true' during the last phase of hibernation, in which devices are
> > being put into low power states and the sleep state (for example,
> > ACPI S4) is finally entered.
> 
> ...this paragraph...
> 
> > Index: linux-2.6/kernel/power/disk.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/disk.c
> > +++ linux-2.6/kernel/power/disk.c
> > @@ -71,6 +71,14 @@ void hibernation_set_ops(struct platform
> >  	mutex_unlock(&pm_mutex);
> >  }
> 
> ....should go somewhere here. Because the name does not imply it is
> for last phases, only...
> 
> > +static bool entering_platform_hibernation;
> > +
> > +bool system_entering_hibernation(void)
> > +{
> > +	return entering_platform_hibernation;
> > +}
> > +EXPORT_SYMBOL(system_entering_hibernation);
> > +
> >  #ifdef CONFIG_PM_DEBUG
> >  static void hibernation_debug_sleep(void)
> >  {
> > @@ -411,6 +419,7 @@ int hibernation_platform_enter(void)
> >  	if (error)
> >  		goto Close;
> >  
> > +	entering_platform_hibernation = true;
> >  	suspend_console();
> 
> Why entering _platform_ hibernation? It will not be set for echo
> shutdown > disk case?

If I remember correctly, no, it won't.

Thanks,
Rafael
