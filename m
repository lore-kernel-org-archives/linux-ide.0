From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata disk corruptor paths ?
Date: Wed, 11 Apr 2007 18:14:02 +0900
Message-ID: <461CA6DA.4060404@gmail.com>
References: <20070330151525.63a5931e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:61284 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXDKJOI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 05:14:08 -0400
Received: by an-out-0708.google.com with SMTP id b33so123472ana
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 02:14:07 -0700 (PDT)
In-Reply-To: <20070330151525.63a5931e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Alan Cox wrote:
> Found these by inspection:
> 
> Command issuing goes via ata_qc_reinit() which sets up the device bits
> for the command to include the device select bit.
> 
> If we are using NCQ then the code in ata_build_rw_tf sets bit 6 directly
> without using |= which clears the device select bit and means any NCQ
> command will go to the first device regardless.
> 
> The non NCQ path thankfully doesn't blat the other bits and right now we
> have no slave devices on NCQ supporting hardware I believe.

The code is actually intended that way.  The NCQ spec mandates the bit
to be zero.  The device/head register layout is..

 FUA  1  Res  0  Res Res Res Res

We probably need better comment there tho.

-- 
tejun
