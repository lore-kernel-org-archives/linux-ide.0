From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: move ide_config_drive_speed() calls to upper layers
Date: Fri, 27 Jul 2007 02:29:03 +0200
Message-ID: <200707270229.03441.bzolnier@gmail.com>
References: <200707270222.28230.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:6697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbXG0Aal (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 20:30:41 -0400
Received: by ug-out-1314.google.com with SMTP id j3so623416ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 17:30:40 -0700 (PDT)
In-Reply-To: <200707270222.28230.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Friday 27 July 2007, Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_HFLAG_POST_SET_MODE host to indicate the need to program the
>   host for the transfer mode after programming the device.  Set it in
>   au1xxx-ide/cs5530/cs5535/pdc202xx_new/sc1200/via82cxxx host drivers.

and amd74xx :)
