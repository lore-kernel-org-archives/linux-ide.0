From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata error
Date: Fri, 25 Jul 2008 19:56:18 +0100
Message-ID: <20080725195618.5f09c3bf@lxorguk.ukuu.org.uk>
References: <6d291e080807251143k6cfc6db1w4e024ac245187d48@mail.gmail.com>
	<6d291e080807251147n14b0f0d1g4c8ad1d4759c702b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51422 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755856AbYGYTNi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jul 2008 15:13:38 -0400
In-Reply-To: <6d291e080807251147n14b0f0d1g4c8ad1d4759c702b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stoyan Gaydarov <stoyboyker@gmail.com>
Cc: linux-ide@vger.kernel.org

> > [ 1078.735322] ata3.00: configured for UDMA/133
> > [ 1078.735336] ata3: EH complete
> > [ 1078.766066] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)

We timed out, reset the drive and it came back.
> > [ 1078.766442] sd 2:0:0:0: [sda] Write Protect is off
> > [ 1078.766448] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > [ 1078.766957] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA
> > [ 1107.310768] [drm] Loading R300 Microcode

I notice there is a drm Loading R300 Microcode logged just before each
drive failure. That seems very suspicious to me. Does it ever occur if
you are not in X ?
