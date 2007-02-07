From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: sata_vsc.c cache line size question
Date: Wed, 7 Feb 2007 00:38:50 -0800
Message-ID: <20070207083850.GA138013@sgi.com>
References: <92952AEF1F064042B6EF2522E0EEF43703EE318A@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:52608 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030526AbXBGIiz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 03:38:55 -0500
Content-Disposition: inline
In-Reply-To: <92952AEF1F064042B6EF2522E0EEF43703EE318A@EXNA.corp.stratus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dailey, Nate" <Nate.Dailey@stratus.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 18, 2007 at 09:42:44AM -0500, Dailey, Nate wrote:
> Okay, trying again as an attachment...
> 
> Nate

Hi Nate, sorry about the delay.  This patch works fine.  Please see
http://linux.yyz.us/patch-format.html and send a new patch, if you would.
Then presumably jgarzik will take it, since it's a good fix.
Or if you want, I could generate the new patch.

Thanks,

jeremy



> 
> -----Original Message-----
> From: Jeremy Higdon [mailto:jeremy@sgi.com] 
> Sent: Thursday, January 18, 2007 2:12 AM
> To: Dailey, Nate
> Cc: linux-ide@vger.kernel.org
> Subject: Re: sata_vsc.c cache line size question
> 
> On Mon, Jan 15, 2007 at 11:26:59AM -0500, Dailey, Nate wrote:
> > Here's a patch that does what you suggest.
> > 
> > Because the default cache line size on my system is 0x10, I tested the
> > patch by checking against this value rather than 0... it worked as
> > expected.
> > 
> > This patch is against 2.6.19.2 that I just downloaded from kernel.org.
> I
> > actually tested on RHEL4 update 4, a 2.6.9 kernel, but I'll try
> building
> > the 2.6.19.2 on my system to make sure it works in that version as
> well.
> > 
> > Nate
> 
> Hi Nate,
> 
> The patch looks fine, except that your mailer wrapped the lines.
> Try sending it as a text attachment instead.
> 
> Thanks
> 
> jeremy
