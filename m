From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
Date: Thu, 29 Sep 2005 00:48:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
References: <43146CC3.4010005@gentoo.org>  <58cb370e05083008121f2eb783@mail.gmail.com>
  <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com>
 <433B16BD.7040409@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.polcom.net ([217.79.151.115]:47280 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750951AbVI1Wro (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2005 18:47:44 -0400
In-Reply-To: <433B16BD.7040409@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On Wed, 28 Sep 2005, Daniel Drake wrote:

> This entry adds needless complication to the driver as it requires the use of
> global variables to be passed into via_get_info(), making things quite ugly
> when we try and make this driver support multiple controllers simultaneously.
>
> This patch removes /proc/via for simplicity.

Is similar data available from sysfs?

As a user of this controller, I think that if it is not then this patch 
should be changed to export it or should be dropped. The data from that 
file is really helpfull in debugging problems (for example related to bad 
cables or breaking disks/cdroms).


Thanks,

Grzegorz Kulewski
