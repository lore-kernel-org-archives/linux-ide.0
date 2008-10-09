From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide dvd burner detected as ide-tape
Date: Thu, 9 Oct 2008 20:50:09 +0200
Message-ID: <200810092050.09576.bzolnier@gmail.com>
References: <200810010100.06299.th@drillich.com> <200810092013.50945.bzolnier@gmail.com> <20081009183925.GA24460@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:10971 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYJISw7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Oct 2008 14:52:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so15552and.103
        for <linux-ide@vger.kernel.org>; Thu, 09 Oct 2008 11:52:58 -0700 (PDT)
In-Reply-To: <20081009183925.GA24460@psychosis.jim.sh>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Thomas Drillich <th@drillich.com>, linux-hotplug@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 09 October 2008, Jim Paris wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Thanks.  Does the following patch help?
> > 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: quirk for LG GH22LP20 DVD burner
> > 
> > LG GH22LP20 DVD burner ("HL)DP-ST@V@-RAI CH22HP20") with firmware 1.00
> > reports 0x01 ("Sequential-access device") as the peripheral device type
> > instead of 0x05 ("CD-ROM device").
> 
> That looks more like a hardware problem with a flakey bit.
> For example GH22LP20 with bit 2 always cleared = CH22HP20.
> DVD-ROM with bit 2 sometimes cleared = @V@-RAI.
> And the peripheral device type also has bit 2 cleared.

This would explain it nicely (I suspected something along these lines
but failed to see the actual pattern).  After all it is very unlikely
to have _that_ broken firmware.

Thanks,
Bart
