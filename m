From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove driver_data direct access of struct device
Date: Fri, 8 May 2009 14:16:14 +0200
Message-ID: <200905081416.15088.bzolnier@gmail.com>
References: <20090430221500.GA18462@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:40443 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZEHMMD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 08:12:03 -0400
Received: by ewy24 with SMTP id 24so1771429ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 05:12:01 -0700 (PDT)
In-Reply-To: <20090430221500.GA18462@kroah.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-ide@vger.kernel.org, Greg KH <greg@kroah.com>

On Friday 01 May 2009 00:15:00 Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> In the near future, the driver core is going to not allow direct access
> to the driver_data pointer in struct device.  Instead, the functions
> dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> have been around since the beginning, so are backwards compatible with
> all older kernel versions.
> 
> Cc: linux-ide@vger.kernel.org
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
