From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
Date: Sun, 25 Jun 2006 04:36:22 -0700
Message-ID: <20060625043622.e42c7254.akpm@osdl.org>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
	<20060624144739.78bde590.akpm@osdl.org>
	<Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932379AbWFYLge (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 07:36:34 -0400
In-Reply-To: <Pine.LNX.4.61.0606251304450.28911@yvahk01.tjqt.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Christian Lohmaier <lohmaier@gmx.de>

On Sun, 25 Jun 2006 13:05:59 +0200 (MEST)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >>            Summary: kernel hangs when trying to read atip wiith cdrecord
> >>     Kernel Version: 2.6.16.1
> 
> >> Most recent kernel where this bug did not occur: 2.6.16.1 (yes, the 
> >> same version - it works with my dvd-burner, but not with my cd-burner), 
> >> the 2.4 series worked with both, but there I have been using ide-scsi)
> 
> Can you try a newer version and/or (or both) with an original cdrecord (if 
> not already done so) or cdrecord-prodvd?
> 
> >> Distribution: Mandriva 9.0 based
> 
> >> cdrtools 2.01.01a10
> 
> >> Steps to reproduce:
> >> I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
> >> # cdrecord dev=ATAPI:1,0,0 -atip
> 
> Try -dev=/dev/hdX
> 

[added Christian (the bug reporter) to cc]
