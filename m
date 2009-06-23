From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: Save a call to PageHighMem()
Date: Tue, 23 Jun 2009 11:48:31 +0200
Message-ID: <200906231148.32675.bzolnier@gmail.com>
References: <20090623101239.2f510604@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:60491 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbZFWJnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 05:43:01 -0400
Received: by fxm9 with SMTP id 9so122248fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 23 Jun 2009 02:43:03 -0700 (PDT)
In-Reply-To: <20090623101239.2f510604@hyperion.delvare>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-ide@vger.kernel.org, David Miller <davem@davemloft.net>

On Tuesday 23 June 2009 10:12:39 Jean Delvare wrote:
> PageHighMem() isn't cheap so avoid calling it twice on the same page.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

PS Please send IDE patches to Dave in the future, thanks.
