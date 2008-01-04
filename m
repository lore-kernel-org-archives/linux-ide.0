From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_pdc202xx_old: Further fixups
Date: Fri, 4 Jan 2008 02:43:41 +0100
Message-ID: <200801040243.41297.bzolnier@gmail.com>
References: <20080104000849.588592ea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:9889 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYADBcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 20:32:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2730500ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 17:32:16 -0800 (PST)
In-Reply-To: <20080104000849.588592ea@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

On Friday 04 January 2008, Alan Cox wrote:
> Turns out distros always enabled burst mode and it is pretty essential so

Yeah and datasheet confirms that so burst mode config option should die
(now if somebody could hit me with a patch)...

Bart
