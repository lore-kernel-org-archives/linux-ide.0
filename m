From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use mutex instead of semaphore in IDE driver
Date: Sat, 5 May 2007 20:55:35 +0200
Message-ID: <200705052055.36061.bzolnier@gmail.com>
References: <20070426092032.GB6468@traven>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:23637 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbXEEUH4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 16:07:56 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1128719muf
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 13:07:55 -0700 (PDT)
In-Reply-To: <20070426092032.GB6468@traven>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Thursday 26 April 2007, Matthias Kaehlcke wrote:
> the IDE driver uses a semaphore as mutex. use the mutex API instead of
> the (binary) semaphore
> 
> Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

applied
