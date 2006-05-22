From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: RE: [PATCH 6/7] sata_mv: endian fix
Date: Mon, 22 May 2006 14:44:42 +0800
Message-ID: <9FCDBA58F226D911B202000BDBAD467306382ECE@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:46543 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932499AbWEVGor (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 02:44:47 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k4M74lIe024997
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 00:04:47 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net [10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4M6iiCh015226
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 01:44:46 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

 
> Zang Roy-r61911 wrote:
> >> Zang Roy-r61911 wrote:
> >>>> This fixes a byte-swap issue on PPC, found by Zang Roy-r61911
> >>>> on the powerpc platform.  His original patch also had some other
> >>>> platform-specific changes in #ifdef's, but I'm not sure 
> yet how to
> >>>> incorporate them.  Look for another patch for those (soon).
> >>>>
> >>>> Signed-off-by: Mark Lord <liml@rtr.ca>
> >>>>
> >>>> ---
> >>>> --- linux/drivers/scsi/sata_mv.c	2006-05-19 
> >>>> 15:44:11.000000000 -0400
> >>>> +++ linux/drivers/scsi/sata_mv.c	2006-05-19 
> >>>> 15:58:21.000000000 -0400
> >>>> @@ -1030,8 +1030,9 @@
> >>>>  
> >>>>  static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 
> >>>> addr, unsigned last)
> >>>>  {
> >>>> -	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | 
> CRQB_CMD_CS |
> >>>> +	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) 
> | CRQB_CMD_CS |
> >>>>  		(last ? CRQB_CMD_LAST : 0);
> >>>> +	*cmdw = cpu_to_le16(tmp);
> >>>>  }
> >>>>  
> >>>>  /**
> >>>>
> >>>
> >>> Does this patch will affect other platform except powerpc?
> >> This patch affects all platforms (as it should).  Most 
> Linux code is 
> >> intentionally written in a cross-platform, portable manner 
> >> without ifdefs.
> >>
> >> 	Jeff
> >>
> >>
> >>
> > I can see it work on powerpc platform, while does it work for other 
> > platform such as i386?
> 
> Yes.  Look at the definition of the function in question:  for little 
> endian platforms, it is a simple assignment.  For big endian 
> platforms, 
> it does the expected byte swap.
> 
> This is also the standard for Linux code:  one function Does 
> The Right 
> Thing, regardless of platform.
> 
> 	Jeff
> 
> 
> 
I see it !
Roy
