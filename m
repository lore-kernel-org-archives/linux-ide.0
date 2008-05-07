From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: again: [PATCH] libata: Add Intel SCH PATA Support
Date: Wed, 7 May 2008 19:38:55 +0200
Message-ID: <200805071938.55804.bzolnier@gmail.com>
References: <20080505172356.636649e6@dxy.sh.intel.com> <200805061820.42493.bzolnier@gmail.com> <20080506165937.68ff4c6f@core>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:23927 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbYEGR3B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 13:29:01 -0400
Received: by nf-out-0910.google.com with SMTP id d3so225807nfc.21
        for <linux-ide@vger.kernel.org>; Wed, 07 May 2008 10:28:59 -0700 (PDT)
In-Reply-To: <20080506165937.68ff4c6f@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alek Du <alek.du@intel.com>, Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Tuesday 06 May 2008, Alan Cox wrote:
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

Not all distros want to use libata SCSI to ATA emulation layer for PATA,
and IDE/ATA subsystem is more embedded friendly (code-size wise etc.).

Thanks,
Bart
