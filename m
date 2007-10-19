From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: New CD/DVD drive - 80-wire cable detection failure
Date: Sat, 20 Oct 2007 00:28:21 +0200
Message-ID: <200710200028.21860.bzolnier@gmail.com>
References: <200710181832.42906.nick@ukfsn.org> <200710192344.27312.bzolnier@gmail.com> <200710192304.23749.nick@ukfsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:42751 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765311AbXJSWWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 18:22:46 -0400
Received: by fk-out-0910.google.com with SMTP id z23so564009fkz
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 15:22:45 -0700 (PDT)
In-Reply-To: <200710192304.23749.nick@ukfsn.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nick@ukfsn.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday 20 October 2007, Nick Warne wrote:
> On Friday 19 October 2007 22:44:27 Bartlomiej Zolnierkiewicz wrote:

> hdparm -I

It should have been hdparm --Istdout (sorry, once again).

[ It is definitevely not my day, or rather trying to debug the problem
  while preparing the next IDE pull request is not a such good idea... ]

>From identify data we should be able to deduce whether this is a kernel
problem or rather a hardware/configuration one.

Thanks,
Bart
