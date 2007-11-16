From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] siimage: remove resetproc() method
Date: Fri, 16 Nov 2007 22:38:22 +0100
Message-ID: <200711162238.22813.bzolnier@gmail.com>
References: <200711161716.16288.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:6346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbXKPVbb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 16:31:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so707017ugc
        for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2007 13:31:30 -0800 (PST)
In-Reply-To: <200711161716.16288.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Friday 16 November 2007, Sergei Shtylyov wrote:
> The intent behind siimage_reset() was probably to hard reset the interface and
> the SATA PHY but as the code writes to two reserved bits instead, it obviously
> has been ineffective from the start. So, just remove it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
