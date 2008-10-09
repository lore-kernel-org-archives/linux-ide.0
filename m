From: Jim Paris <jim@jtan.com>
Subject: Re: ide dvd burner detected as ide-tape
Date: Thu, 9 Oct 2008 14:39:25 -0400
Message-ID: <20081009183925.GA24460@psychosis.jim.sh>
References: <200810010100.06299.th@drillich.com> <200810082125.58994.bzolnier@gmail.com> <200810091643.53702.th@drillich.com> <200810092013.50945.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.jim.sh ([75.150.123.25]:56861 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbYJIStL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Oct 2008 14:49:11 -0400
Content-Disposition: inline
In-Reply-To: <200810092013.50945.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Thomas Drillich <th@drillich.com>, linux-hotplug@vger.kernel.org, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Thanks.  Does the following patch help?
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: quirk for LG GH22LP20 DVD burner
> 
> LG GH22LP20 DVD burner ("HL)DP-ST@V@-RAI CH22HP20") with firmware 1.00
> reports 0x01 ("Sequential-access device") as the peripheral device type
> instead of 0x05 ("CD-ROM device").

That looks more like a hardware problem with a flakey bit.
For example GH22LP20 with bit 2 always cleared = CH22HP20.
DVD-ROM with bit 2 sometimes cleared = @V@-RAI.
And the peripheral device type also has bit 2 cleared.

-jim
