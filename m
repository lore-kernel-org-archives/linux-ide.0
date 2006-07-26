From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch, rft] amd74xx: implement suspend-to-ram
Date: Tue, 25 Jul 2006 17:27:11 -0700
Message-ID: <200607251727.12678.david-b@pacbell.net>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <20060724005340.GA4073@opus.vpn-dev.reflex> <20060725230955.GB7220@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:43605 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932509AbWGZA1P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jul 2006 20:27:15 -0400
In-Reply-To: <20060725230955.GB7220@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@suse.cz>, Jason Lunz <lunz@falooley.org>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

On Tuesday 25 July 2006 4:09 pm, Pavel Machek wrote:

> 
> > +	if(state.event == PM_EVENT_SUSPEND) {
> 
> "if (". Ouch 

He already got that feedback, along with the fact that PM_EVENT_SUSPEND
gets called in _all_ suspend sequences not just "standby" and STR.  That
comment just needs to be removed.  :)


> and please don't do this. Suspend-to-disk will call 
> amd74xx_resume when it needs to talk to the disk.

I don't understand the rest of this comment.  That code looks
correct (other than calling the goofy/broken pci_choose_state thing);
PM_EVENT_FREEZE and PM_EVENT_PRETHAW should not disable the device.

So what "this" are you suggesting he not do ... and why?  


> > +		pci_disable_device(dev);
> > +		pci_set_power_state(dev, pci_choose_state(dev, state));
> > +	}
> > +	return 0;
> > +}
> 
> 
