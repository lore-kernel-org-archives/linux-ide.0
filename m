From: Alek Du <alek.du@intel.com>
Subject: Re: again: [PATCH] libata: Add Intel SCH PATA Support
Date: Wed, 7 May 2008 10:14:23 +0800
Message-ID: <20080507101423.7259f450@dxy.sh.intel.com>
References: <20080505172356.636649e6@dxy.sh.intel.com>
	<48204A67.7070308@pobox.com>
	<20080506213141.06b86099@dxy.sh.intel.com>
	<200805061820.42493.bzolnier@gmail.com>
	<20080506165937.68ff4c6f@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22855 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbYEGCVS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 22:21:18 -0400
In-Reply-To: <20080506165937.68ff4c6f@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Hi,

On Tue, 6 May 2008 16:59:37 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Tue, 6 May 2008 18:20:42 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Tuesday 06 May 2008, Alek Du wrote:
> > > Hi Jeff, Alan, Sergei, Bartlomiej
> > > 
> > > Modified again according to your good comments! Hope this time it is ok. :-)
> > 
> > Hi,
> > 
> > Looks good, are you going to submit IDE version soon?
> 
> Is there any point adding new drivers to the old IDE layer nowdays ?

Yeah, I really was hesitating to write the corresponding IDE driver for a while. If it really could help
people who have good reason to use IDE layer instead of libata, I will do that.

Thanks,
Alek
