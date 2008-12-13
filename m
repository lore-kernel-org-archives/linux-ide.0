From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: add ide_[un]lock_hwgroup() helpers
Date: Sun, 14 Dec 2008 00:15:51 +0100
Message-ID: <200812140015.51978.bzolnier@gmail.com>
References: <200811182116.00351.bzolnier@gmail.com>  <alpine.DEB.1.00.0811190236550.24738@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:9435 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYLMXSm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Dec 2008 18:18:42 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1144816muf.1
        for <linux-ide@vger.kernel.org>; Sat, 13 Dec 2008 15:18:41 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811190236550.24738@zirkon.biophys.uni-duesseldorf.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Elias Oltmanns <eo@nebensachen.de>


[ Sorry for the late reply. ]

On Wednesday 19 November 2008, Michael Schmitz wrote:
> > -	while (!hwgroup->busy) {
> > -		hwgroup->busy = 1;
> > -		/* for atari only */
> > -		ide_get_lock(ide_intr, hwgroup);
> > +	while (!ide_lock_hwgroup(hwgroup)) {
> 
> Something I've run into while working on the locking stuff: what happens if the 
> above ide_lock_hwgroup(hwgroup) sleeps for long enough to trigger the request 
> timer? 

AFAICS this happens before the hwgroup timeout timer is armed and IDE is not
using block layer request timers yet so we should be fine here..

Thanks,
Bart
