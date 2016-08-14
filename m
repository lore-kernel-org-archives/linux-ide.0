From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 10:56:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1608141055350.22463-100000@netrider.rowland.org>
References: <20160814120327.GA8292@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160814120327.GA8292@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, David Lang <david@lang.hm>, Tom Yan <tom.ty89@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, james harvey <jamespharvey20@gmail.com>, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>
List-Id: linux-ide@vger.kernel.org

On Sun, 14 Aug 2016, Pavel Machek wrote:

> > That being said, it would be great if the original reporter could use
> > 'git bisect' and let the linux-usb and linux-scsi mailing list know what
> > the offending patch is, and we can take it from there.
> 
> Original reporter is me :-(.
> 
> Yes, I can do bisect, if required. I'd like some kind of confirmation
> that it happens on other systems...

Can you post a kernel log from one of those unsuccessful boots
(netconsole or something or the sort)?

Alan Stern
