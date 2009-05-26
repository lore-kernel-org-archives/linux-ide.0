From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Tue, 26 May 2009 19:15:46 +0200
Message-ID: <200905261915.47212.bzolnier@gmail.com>
References: <200905252344.11826.bzolnier@gmail.com> <200905261423.40117.bzolnier@gmail.com> <20090526135343.5bcaa92b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:42750 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZEZRLl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 May 2009 13:11:41 -0400
In-Reply-To: <20090526135343.5bcaa92b@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 May 2009 14:53:43 Alan Cox wrote:
> > Please note that no fancy sysfs support was needed to prevent the problem:
> > both stacks (ide & libata) support HDIO_DRIVE_TASK ioctl which can be used
> > to execute commands needed to retrieve/change HPA setting.
> 
> Wrong. You need sysfs support because you may not be able to retrieve the
> HPA settings after the drive has removed them. You also need a trigger of

All information was there (kernel logs).

Moreover the default in libata is to not remove HPA settings.

I don't recommend parsing kernels logs in search of such information but
you're are stretching the reality too far to match with your arguments.
