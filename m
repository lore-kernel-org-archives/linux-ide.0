From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/12] ali14xx: add "vlb_clock=" parameter
Date: Sat, 15 Mar 2008 22:44:11 +0100
Message-ID: <200803152244.12050.bzolnier@gmail.com>
References: <20080313224352.7051.44005.sendpatchset@localhost.localdomain> <20080315123614.6c548306@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:44895 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbYCOVaz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 17:30:55 -0400
Received: by fg-out-1718.google.com with SMTP id l27so875529fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 15 Mar 2008 14:30:54 -0700 (PDT)
In-Reply-To: <20080315123614.6c548306@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 15 March 2008, Alan Cox wrote:
> On Thu, 13 Mar 2008 23:43:52 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > Add "vlb_clock=" parameter for specifying VLB clock frequency (in MHz).
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Surely this value should be set once per system (ditto for PCI) not
> something you have to set in each specific driver on the box ?

Yeah, I'll re-do the patches.  Thanks for pointing this out.

Bart
