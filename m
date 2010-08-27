From: adam radford <aradford@gmail.com>
Subject: Re: 3w-9xxx: scsi0: WARNING: (0x06:0x0037): Character ioctl (0x108)
 timed out, resetting card.
Date: Fri, 27 Aug 2010 09:29:42 -0700
Message-ID: <AANLkTik0BSJC5DJtVNw-MA9cuoAEUrw-M1Dn4XaF99u4@mail.gmail.com>
References: <alpine.DEB.2.00.1008270907110.5274@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1008270907110.5274@p34.internal.lan>
Sender: linux-scsi-owner@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 27, 2010 at 6:12 AM, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

> Aug 24 09:14:04 p34 kernel: [247295.662461] 3w-9xxx: scsi0: WARNING:
> (0x06:0x0037): Character ioctl (0x108) timed out, resetting card.

Justin,

This just means the firmware didn't complete an ioctl in 60 seconds.

Can try changing this define in 3w-9xxx.h:

#define TW_IOCTL_CHRDEV_TIMEOUT               60 /* 60 seconds */

to 90 or 120 seconds to see if that fixes your issue?

Thanks,

-Adam
