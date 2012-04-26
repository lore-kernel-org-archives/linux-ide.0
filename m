From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Thu, 26 Apr 2012 21:06:11 +0800
Message-ID: <CAF1ivSZuBrqX5iqVH3W+qRf_qoZXwAtO1iA8dHEqmTGkB-F_HA@mail.gmail.com>
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
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47372 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab2DZNGM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2012 09:06:12 -0400
Received: by vcqp1 with SMTP id p1so875054vcq.19
        for <linux-ide@vger.kernel.org>; Thu, 26 Apr 2012 06:06:12 -0700 (PDT)
In-Reply-To: <CAMHSBOXFEEgL31K+OFOY9bXtbCvHBBeKN-VdznpA3UekaFqGdw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Jeff Garzik <jgarzik@pobox.com>, cwillu <cwillu@cwillu.com>, Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Grant Grundler <grundler@google.com>

On Thu, Apr 26, 2012 at 5:29 PM, Gwendal Grignou <gwendal@google.com> wrote:
> Lin,

Hi Gwendal,

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

This could also fix the regression.

But the fundamental problem is should ata_ering_map still iterate the old
error history which were cleared already?

Lin Ming

>
> Gwendal.
