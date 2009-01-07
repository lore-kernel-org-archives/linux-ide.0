From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2] it821x: Add ultra_mask quirk for Vortex86SX
Date: Wed, 7 Jan 2009 21:21:57 +0100
Message-ID: <200901072121.57949.bzolnier@gmail.com>
References: <20090105165811.GF29255@jenkins.ifup.org> <20090105171104.5db48c74@lxorguk.ukuu.org.uk> <20090105190858.GC22062@jenkins.ifup.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:53136 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbZAGUc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 15:32:26 -0500
Received: by fxm13 with SMTP id 13so1647858fxm.13
        for <linux-ide@vger.kernel.org>; Wed, 07 Jan 2009 12:32:24 -0800 (PST)
In-Reply-To: <20090105190858.GC22062@jenkins.ifup.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brandon Philips <brandon@ifup.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Shawn Lin <shawn@dmp.com.tw>

On Monday 05 January 2009, Brandon Philips wrote:
> On Vortex86SX with IDE controller revision 0x11 ultra DMA must be
> disabled. This patch was tested by DMP and seems to work.
> 
> It is a cleaned up version of their older Kernel patch: 
>  http://www.dmp.com.tw/tech/vortex86sx/patch-2.6.24-DMP.gz
> 
> Tested-by: Shawn Lin <shawn@dmp.com.tw>
> Signed-off-by: Brandon Philips <bphilips@suse.de>

applied
