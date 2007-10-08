From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: make jmicron match vendor and device class
Date: Mon, 8 Oct 2007 23:01:13 +0200
Message-ID: <200710082301.13578.bzolnier@gmail.com>
References: <20071008022139.GE12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:59801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbXJHVjp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:45 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370193nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:44 -0700 (PDT)
In-Reply-To: <20071008022139.GE12186@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, ethanhsiao@jmicron.com, justin@jmicron.com

On Monday 08 October 2007, Tejun Heo wrote:
> PATA part of all current JMB controllers behave the same way and
> JMicron confirms that all future ones will stay compatible.  Matching
> vendor and device class is enough.
> 
> For backward compatibility, jmicron still needs to match 361,3,5,6,8
> DIDs regardless of device class if libata is not configured but won't
> need further DID update from this point.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
> Cc: Justin Tsai <justin@jmicron.com>

applied, thanks
