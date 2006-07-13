From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] ata_piix: attempt to fix
Date: Thu, 13 Jul 2006 16:50:38 -0700
Message-ID: <20060713235038.GA3613@kroah.com>
References: <20060711160202.GA2503@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:42199 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161052AbWGMXwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jul 2006 19:52:23 -0400
Content-Disposition: inline
In-Reply-To: <20060711160202.GA2503@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, albertcc@tw.ibm.com

On Tue, Jul 11, 2006 at 12:02:02PM -0400, Jeff Garzik wrote:
> This patch attempts to address problems on ata_piix that people have
> been reporting:  long boot delay, ghost devices, and ICH8 brokenness.
> 
> Testing feedback is requested as soon as possible, so that we can
> potentially stick this into 2.6.18-rc2.
> 
> I'm booting up several boxes locally here, mainly ICH5 and ICH8, as well.

Sorry for the delay, but no, this does not solve the timeout at boot for
me.  Do you need the boot log messages?

thanks,

greg k-h
