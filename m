From: "Bahadir Balban" <bahadir.lists@googlemail.com>
Subject: Re: flushing cache after block io
Date: Thu, 3 May 2007 14:25:44 +0100
Message-ID: <97bec2470705030625u1a0117b3h1cd2d46c06ee035e@mail.gmail.com>
References: <97bec2470705010658s48c70ba2pc5310efa533a96ea@mail.gmail.com>
	 <46377D10.9090605@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:26031 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbXECNZt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 09:25:49 -0400
Received: by nz-out-0506.google.com with SMTP id o1so501142nzf
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 06:25:44 -0700 (PDT)
In-Reply-To: <46377D10.9090605@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On 5/1/07, Mark Lord <liml@rtr.ca> wrote:
>
> Russell, didn't you go through all of this pain and fix it
> a year or two ago?
>
> Bahadir, exactly what kernel/version is this with?
>
>

This is on 2.6.19 but I'm unsure if there's a fix in the tree as I
might be one of the few to try ARM MPCore with a block device.
Although, filesystems over mtd or nfs work fine without the flushing.

If you have an idea please let me know.

Thanks,
Bahadir
