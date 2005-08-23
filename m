From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #2
Date: Tue, 23 Aug 2005 16:43:51 -0600
Message-ID: <4789af9e050823154364c8e9eb@mail.gmail.com>
References: <355e5e5e05080103021a8239df@mail.gmail.com>
	 <4789af9e050823124140eb924f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:54554 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932468AbVHWWn5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Aug 2005 18:43:57 -0400
Received: by zproxy.gmail.com with SMTP id r28so944697nza
        for <linux-ide@vger.kernel.org>; Tue, 23 Aug 2005 15:43:54 -0700 (PDT)
In-Reply-To: <4789af9e050823124140eb924f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>, Lukasz Kosewski <lkosewsk@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/23/05, Jim Ramsay <jim.ramsay@gmail.com> wrote:
> Then I must have found an undocumented feature!  I've applied this set
> of patches to a 2.6.11 kernel (with few problems) and ran into a bunch
> of "scheduling while atomic" errors when hotplugging a drive, culprit
> being probably scsi_sysfs.c where scsi_remove_device locks a mutex, or
> perhaps when it then calls class_device_unregister, which does a
> 'down_write'.

After further debugging, it appears that the problem is the debounce
timer in libata-core.c.

Timers appear to operate in an atomic context, so timers should not be
allowed to call scsi_remove_device, which eventually schedules.

Any suggestions on the best way to fix this?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
