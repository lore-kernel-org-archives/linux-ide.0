From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.24-rc3] aec62xx: Fix kernel oops in driver's probe function
Date: Sun, 18 Nov 2007 22:43:42 +0100
Message-ID: <200711182243.42554.bzolnier@gmail.com>
References: <200711172243.57087.biblbroks@sezampro.yu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:55506 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbXKRVkH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 16:40:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so869069ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 13:40:05 -0800 (PST)
In-Reply-To: <200711172243.57087.biblbroks@sezampro.yu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aleksandar Radovanovic <biblbroks@sezampro.yu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org

On Saturday 17 November 2007, Aleksandar Radovanovic wrote:
> From: Aleksandar Radovanovic <biblbroks@sezampro.yu>
> 
> Add pci_enable_device() to aec62xx probe function
> before doing any I/O.
> 
> Original probe function tries to read from device's
> PCI region 4 before calling ide_setup_pci_device().
> Since the device is not enabled at this point,
> on machines that have no firmware PCI initialization
> (e.g. ASUS WL-700gE router), corresponding PCI BAR 
> is 0 and the following inb() causes a kernel oops.
> 
> Signed-off-by: Aleksandar Radovanovic <biblbroks@sezampro.yu>

applied, thanks!
