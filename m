From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2.6.25-rc9] ATA/IDE: fix platform driver hotplug/coldplug
Date: Thu, 17 Apr 2008 01:02:25 +0200
Message-ID: <200804170102.26377.bzolnier@gmail.com>
References: <200804131011.13404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:37060 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbYDPWtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:49:51 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2589881fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:49:11 -0700 (PDT)
In-Reply-To: <200804131011.13404.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, kay.sievers@vrfy.org

On Sunday 13 April 2008, David Brownell wrote:
> From: Kay Sievers <kay.sievers@vrfy.org>
> 
> Since 43cc71eed1250755986da4c0f9898f9a635cb3bf, the platform
> modalias is prefixed with "platform:". Add MODULE_ALIAS() to the
> hotpluggable ATA and IDE platform drivers, to re-enable auto loading.
> 
> NOTE:  both ata/pata_platform.c and ide/legacy/ide_platform.c claim
> to provide "the" platform_pata driver, and there's no build-time
> mutual exclusion mechanism.  This means that configs which enable
> both drivers will make some trouble when hotplugging...
> 
> [ dbrownell@users.sourceforge.net: more drivers, registration fixes ]
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
