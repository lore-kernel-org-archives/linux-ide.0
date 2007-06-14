From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PROBLEM + PATCH] Sata port disabled by BIOS gets initialized
Date: Thu, 14 Jun 2007 18:27:26 +0900
Message-ID: <467109FE.1080009@gmail.com>
References: <20056641.1181568752111.JavaMail.root@wombat.diezmil.com> <466D8C4C.8040605@gmail.com> <466EE66B.1040905@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:2566 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXFNJ1c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 05:27:32 -0400
Received: by nz-out-0506.google.com with SMTP id n1so525902nzf
        for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 02:27:31 -0700 (PDT)
In-Reply-To: <466EE66B.1040905@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: shyam_iyer@dell.com, linux-ide@vger.kernel.org

Hello,

Matt Sealey wrote:
> Isn't there a case for speeding up boot and not wasting resources by
> respecting BIOS settings in this regard? If you have an 8-port
> controller on a board and one disk, forcing all of them enabled
> regardless of BIOS settings is just 7 redundant port scans.

Ports can be populated later with hotplug.

> It should at least be an option - the default being to open up all
> gunports, an option to respect BIOS settings and only use the ones
> requested and enabled.. (I can see an edge case where a user disables
> a disk in the BIOS to stop another OS from looking at/for it, but
> wants the Linux system to boot from it)

There hasn't been any actual need for such an option.  Yes, there are
situations where such option might help theoretically but how much?  If
you have an actual strong case for such option, I'm all ears.

-- 
tejun
