From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Sat, 5 May 2007 21:30:53 +0200
Message-ID: <200705052130.53793.bzolnier@gmail.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:43592 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbXEEUIC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 16:08:02 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1091600ika
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 13:08:00 -0700 (PDT)
In-Reply-To: <200705042318.37367.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: michal.kepien@poczta.onet.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 04 May 2007, Sergei Shtylyov wrote:
> HPT36x chip don't seem to have the channel enable bits, so prevent the IDE core
> from checking them...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
