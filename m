From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] cdrom: longer timeout for "Read Track Info" command
Date: Tue, 2 Jan 2007 10:28:29 +0000
Message-ID: <20070102102829.4117b230@localhost.localdomain>
References: <20070102023623.GA3108@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58342 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932732AbXABKSd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 05:18:33 -0500
In-Reply-To: <20070102023623.GA3108@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org

On Mon, 1 Jan 2007 18:36:24 -0800
Jeremy Higdon <jeremy@sgi.com> wrote:

> I have a DVD combo drive and a CD in which the
> "READ TRACK INFORMATION" command (implemented in the
> cdrom_get_track_info() function) takes about 7 seconds to run.
> The current implementation of cdrom_get_track_info() uses the
> default timeout of 5 seconds.  So here's a patch that increases
> the timeout from 5 to 15 seconds.
> 
> The drive in question is a TSSTcorpCD/DVDW SN-S082D, and I have
> a Silicon Image 680A adapter, in case that's of interest.
> 
> signed-off-by: <jeremy@sgi.com>

Please test with a seven second timeout rather than fifteen which is way
longer than anyone wants to wait. Seven is the magic value used by
another major vendor so ought to be right for all hardware 8)
