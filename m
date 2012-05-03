From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Thu, 3 May 2012 09:26:28 +0800
Message-ID: <CAF1ivSYpxyRXDiup8AxPGYawXoThR-KuNCC1E4Os_1vhUYx-DA@mail.gmail.com>
References: <4F8DD4DC.4050503@teksavvy.com>
	<4F8DD708.8050502@teksavvy.com>
	<4F8DD834.5070000@teksavvy.com>
	<4F8DDA53.206@teksavvy.com>
	<CAE5mzvjsfX34fod0KURNQN8Rmn0xOPCdP2iY2xnSTnnRXPAaEQ@mail.gmail.com>
	<4F8EF57E.4070603@fold.natur.cuni.cz>
	<4F8EF9F7.5040202@pobox.com>
	<4F8EFD89.2080603@fold.natur.cuni.cz>
	<4F8F08D7.6050809@fold.natur.cuni.cz>
	<CAF1ivSYqzjv10F+sdYkR_jdTZvzKP1=_ZwgNDj2njnmb6uaenA@mail.gmail.com>
	<1334823362.11188.172.camel@minggr>
	<CANEJEGuPG1yAwZ0xwQcbfnTghs7cnnJ2=NLpxMEVuFd0H7KStA@mail.gmail.com>
	<CAMHSBOXFEEgL31K+OFOY9bXtbCvHBBeKN-VdznpA3UekaFqGdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57978 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab2ECB03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 21:26:29 -0400
Received: by vcqp1 with SMTP id p1so930330vcq.19
        for <linux-ide@vger.kernel.org>; Wed, 02 May 2012 18:26:28 -0700 (PDT)
In-Reply-To: <CAMHSBOXFEEgL31K+OFOY9bXtbCvHBBeKN-VdznpA3UekaFqGdw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Jeff Garzik <jgarzik@pobox.com>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Grant Grundler <grundler@google.com>

On Thu, Apr 26, 2012 at 5:29 PM, Gwendal Grignou <gwendal@google.com> wrote:
> Lin,
>
> In the patch d9027470b88631d0956ac37cdadfdeb9cdcf2c99, I did limit the
> amount of data cleaning in some of the ata objects.
>
> If setting err_mask to 0 masks the regression I introduced in the
> patch, I may have altered too much how ata_device object is
> reinitialized when a device is found. I am digging deeper, I may have
> change the code to try to preserve the ering as much as possible.
>
> Concerning your patch, isn't adding a test (ent->eflags &
> ATA_EFLAG_OLD_ER) in ata_count_probe_trials_cb() more in line with
> speed_down_verdict_cb() code?

Hi,

I have updated the patch.

[PATCH] libata: skip old error history when counting probe trials
http://marc.info/?l=linux-ide&m=133600832126645&w=2

Regards,
Lin Ming
