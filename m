From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3.3.y] libata: forbid port runtime pm by default, fixing
 regression
Date: Fri, 25 May 2012 02:30:17 +0900
Message-ID: <20120524173017.GA28703@kroah.com>
References: <4F8DD4DC.4050503@teksavvy.com>
 <4F8DD708.8050502@teksavvy.com>
 <4F8DD834.5070000@teksavvy.com>
 <4F8DDA53.206@teksavvy.com>
 <CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>
 <4F8EF57E.4070603@fold.natur.cuni.cz>
 <4F8EF9F7.5040202@pobox.com>
 <20120519235854.GA32208@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58412 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965213Ab2EXVZF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2012 17:25:05 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so299865dad.19
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2012 14:25:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120519235854.GA32208@burratino>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org, Michael Schmitt <tcwardrobe@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, May 19, 2012 at 06:58:54PM -0500, Jonathan Nieder wrote:
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Wed, 18 Apr 2012 09:29:47 +0800
> 
> commit 0c8d32c27f5cf6e14ca14b4758d1e994eebd50fd upstream.
> 
> Forbid port runtime pm by default because it has known hotplug issue.
> User can allow it by, for example
> 
> echo auto > /sys/devices/pci0000:00/0000:00:1f.2/ata2/power/control
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi Greg,
> 
> Please consider
> 
>   0c8d32c27f5c libata: forbid port runtime pm by default, fixing
>                regression
> 
> for inclusion in the 3.3-stable tree.  (It should apply there cleanly.
> The copy in this message is just for easy reference.)

Now applied, thanks for letting me know.

greg k-h
