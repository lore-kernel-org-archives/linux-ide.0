From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] : IDE-CS Add additional id string (corsair, 1GB)
Date: Tue, 16 Oct 2007 21:35:51 +0200
Message-ID: <200710162135.51149.bzolnier@gmail.com>
References: <20071014210403.13d6f560.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.181]:8607 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936054AbXJPUto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 16:49:44 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1146442ika
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 13:49:42 -0700 (PDT)
In-Reply-To: <20071014210403.13d6f560.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 15 October 2007, Kristoffer Ericson wrote:
> Greetings,
> 
> The manf string looks weird (0x0 + 0x0), but I assume its correct. Also,
> whitespaces seems almost intentional, so am I missing something? 

Nope, thanks for cleaning this.

> Shortlog:
> This patch adds id strings for Corsair 1GB (identified as Hyperstone Model1)
> inside legacy/ide-cs.c 
> 
> It also includes some minor whitespace cleanups.
> 
> Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

applied
