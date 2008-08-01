From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide pmac breakage
Date: Fri, 1 Aug 2008 12:54:02 +0200
Message-ID: <200808011254.02989.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop> <1217478322.11188.410.camel@pasglop> <200807311251.02251.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:48761 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbYHAK4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 06:56:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so819985fkq.5
        for <linux-ide@vger.kernel.org>; Fri, 01 Aug 2008 03:56:30 -0700 (PDT)
In-Reply-To: <200807311251.02251.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com


On Thursday 31 July 2008, Bartlomiej Zolnierkiewicz wrote:

[...]

Sorry if my mails were a bit harsh but nobody likes to be pushed around.

[ It is not like I don't want to add proper hot-plugging support or do test
  on more hardware but my time schedule is already tight enough and there are
  still more fundamental things to address (which take priority). ]

> -                host->dev[0] = hws[0]->dev;
> +                host->dev[0] = hws[0]->parent ? hws[0]->parent : hws[0]->dev;
> 
> Could you please try it together with my previous patch for
> ide_device_{get,put}()?

Please test it when you have some time.
