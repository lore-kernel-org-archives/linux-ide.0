From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Fri, 29 Jun 2007 01:27:29 +0900
Message-ID: <4683E171.1090306@gmail.com>
References: <4683DCD3.1040303@gmail.com> <87f94c370706280914v7b52a7d7k31d323b9d88da19b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:29528 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624AbXF1Q1f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 12:27:35 -0400
Received: by nz-out-0506.google.com with SMTP id s18so152882nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 09:27:35 -0700 (PDT)
In-Reply-To: <87f94c370706280914v7b52a7d7k31d323b9d88da19b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> Does it simply fail?  Or does it corrupt?
> 
> In my Windows experience, if you try to write data past ~128GiB and
> you don't have LBA48 support you get a wraparound effect that causes
> corruption of the data below ~128GiB.  I've seen it happen several
> times under Win2K in particular.

It will probably wrap and corrupt data.  The driver is already marked
HIGHLY EXPERIMENTAL.  Do you think we need bigger hammer?

-- 
tejun
