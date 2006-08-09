From: Greg KH <greg@kroah.com>
Subject: Re: [git patches] libata fixes
Date: Wed, 9 Aug 2006 11:47:49 -0700
Message-ID: <20060809184749.GA12941@kroah.com>
References: <20060809062514.GA27491@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:10978 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751316AbWHISsK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 14:48:10 -0400
Content-Disposition: inline
In-Reply-To: <20060809062514.GA27491@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Aug 09, 2006 at 02:25:14AM -0400, Jeff Garzik wrote:
> 
> Please pull from 'upstream-greg' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg

Applied, thanks.

Hm, should these fixes solve my SATA cdrom driver timeout issue?  I'll
go test that, it was still broken in 2.6.18-rc4...

thanks,

greg k-h
