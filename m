From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Wed, 27 Aug 2008 20:29:31 +0300
Message-ID: <c70ff3ad0808271029u7f53f5ffkd44eacd996da5cb2@mail.gmail.com>
References: <200808261045.33241.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:42050 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYH0R3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Aug 2008 13:29:32 -0400
Received: by gxk10 with SMTP id 10so4360186gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 27 Aug 2008 10:29:31 -0700 (PDT)
In-Reply-To: <200808261045.33241.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Tue, Aug 26, 2008 at 11:45 AM, Frans Pop <elendil@planet.nl> wrote:
> Starting with kernel 2.6.26 I've noticed that the harddisk (HDD) led on my
> QNAP TS-109 (which has a Marvel SATA controller as platform device) no
> longer flashes when there is disk activity. Instead it will just
> stay "on" all the time. The led worked fine with 2.6.25.
>
Frans, does the LED stay "on" even when there is no disk activity?
