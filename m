From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/9] libata: implement per-dev xfermask
Date: Wed, 09 Aug 2006 00:30:33 -0400
Message-ID: <44D964E9.9070207@pobox.com>
References: <11547252932391-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:5789 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030463AbWHIEah (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 00:30:37 -0400
In-Reply-To: <11547252932391-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement per-dev xfermask.  libata used to determine xfermask
> per-port - the fastest mode of the slowest device on the port.  This
> patch enables per-dev xfermask.
> 
> Original patch is from Alan Cox <alan@redhat.com>.  The following
> changes are made by me.
> 
> * simplex warning message is added
> * fix port-wide PIO mode selection to aovid violating device selection
>   timing.

Since Alan squawked, perhaps break the port-wide PIO mode selection into 
a separate patch, so that the other stuff can go in?

Then longer term we can figure out what it the best course of action.


