From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [git patches] libata updates
Date: Tue, 1 May 2007 14:38:07 -0700
Message-ID: <200705011438.07499.jesse.barnes@intel.com>
References: <20070429161542.GA12501@havoc.gtf.org> <46364C04.4050208@garzik.org> <46364FFA.9050500@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:32282 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423690AbXEAVh5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 17:37:57 -0400
In-Reply-To: <46364FFA.9050500@seclark.us>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Jeff Garzik <jeff@garzik.org>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Monday, April 30, 2007 1:22 pm Stephen Clark wrote:
> Please don't do this!
>
> Yeah the kernel will boot but the hd performance is sh*t on my
> laptop. I am running FC6 with
> kernel 2.6.21 and without the combined_mode setting my disk
> performance goes down to a
> whopping 1.25mb/sec from 44mb/sec when I boot with
> combined_mode=libata. It make my
> system unusable!

So your performance is good when you add combined_mode=libata?  I hope 
so, because that's why I added it in the first place...

However, Jeff's patch won't steal your performance as long as you make 
sure you use the libata based drivers for everything.  If you're 
running Fedora I think the rawhide kernels are configured this way, but 
the fc6 era kernels aren't.

Jesse
