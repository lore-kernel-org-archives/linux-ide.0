From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/8] ide: make legacy IDE VLB modules check for the "probe" kernel params
Date: Wed, 14 Feb 2007 12:19:52 +0100
Message-ID: <200702141219.52236.bzolnier@gmail.com>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain> <200702141207.27483.bzolnier@gmail.com> <20070214111744.76553c43@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:36891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXBNLOK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 06:14:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so147977uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 03:14:09 -0800 (PST)
In-Reply-To: <20070214111744.76553c43@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


On Wednesday 14 February 2007 12:17, Alan wrote:
> > > No point obsoleting the old ones. By the time being obsolete turns into
> > > being anything like "gone", the hardware won't exist. It just causes
> > 
> > We don't have stable rules for kernel parameters.
> 
> We have fifteen years of traditional, common sense and the like
> 
> > I'll make warnings more verbose, i.e.
> > 
> > 'please use "ali14xx.probe" boot option instead of obsoleted "ide0=probe"'
> 
> Just leave the old option in as well, nobody needs to care that you are
> changing it.

The old options are still here but OK I won't obsolete them until all "idex="
options get obsoleted.

Bart
