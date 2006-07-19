From: Edward Falk <efalk@google.com>
Subject: Re: libata SATA support for Sil 3726 port multiplier
Date: Tue, 18 Jul 2006 17:21:02 -0700
Message-ID: <44BD7AEE.8020805@google.com>
References: <Pine.LNX.4.64.0607040538040.12712@mail.ezic.com> <44B3D0B6.7070506@coplanar.net> <Pine.LNX.4.64.0607111807240.23635@mail.ezic.com> <44BD72BD.70105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:25761 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932230AbWGSAWa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Jul 2006 20:22:30 -0400
In-Reply-To: <44BD72BD.70105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Fredrik Sjoholm <fredrik@sjoholm.com>, Jeremy Jackson <jerj@coplanar.net>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


> Yes, we have yet to implement staggered spinup support with someway to 
> control the number of concurrently spun up devices.  It's on my agenda. 
>  SATA staggered spinup is enabled by loading certain pin in the power 
> connector during power-up.  So, it is the enclosure which determines 
> whether staggered spin-up is enabled or disabled.  Your enclosure may 
> have a dip switch or something to control that.

Doing staggered spinup properly is a tricky thing -- the sequence that 
spins up the drive is the same sequence that detects the drive.  This 
means that simply probing the controller for disk drives will spin them 
up.  So staggered spinup means staggered probling.  Tricky.

	-ed falk
