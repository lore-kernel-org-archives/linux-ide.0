From: "Monty Montgomery" <monty@xiph.org>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Date: Thu, 9 Nov 2006 15:13:19 -0500
Message-ID: <806dafc20611091213x2a82c5ccs814ceabbf11e2363@mail.gmail.com>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
	 <20061030114503.GW4563@kernel.dk>
	 <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>
	 <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org>
	 <45533468.1060400@gmail.com> <455337B8.5000902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:62777 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161829AbWKIUNU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 15:13:20 -0500
Received: by nz-out-0102.google.com with SMTP id l1so212222nzf
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 12:13:19 -0800 (PST)
In-Reply-To: <455337B8.5000902@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Brice Goglin <Brice.Goglin@ens-lyon.org>, Jens Axboe <jens.axboe@oracle.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Douglas Gilbert <dougg@torque.net>

On 11/9/06, Jeff Garzik <jgarzik@pobox.com> wrote:

> Mapping 'bidirectional' is a bit difficult.

SGIO_TO_FROM_DEVICE is *not* bdirectional!

>From the header that defines it:

#define SG_DXFER_TO_FROM_DEV -4 /* treated like SG_DXFER_FROM_DEV with the
                                   additional property than during indirect
                                   IO the user buffer is copied into the
                                   kernel buffers before the transfer */

That's pretty darned clear.  TO_FROM_DEVICE is a straight-up read.
Why the continuing confusion of what this mode is for?

> Given that there are stupid apps/libs out there in the field with this
> behavior, even if the apps are fixed I think we are stuck with the
> stupidities.

*ahem*

Monty
