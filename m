From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Re: 2.4.22-rc2 ext2 filesystem corruption
Date: Sun, 4 Jan 2004 03:07:48 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200401040307.48530.bzolnier@elka.pw.edu.pl>
References: <200310311941.31930.bzolnier@elka.pw.edu.pl> <20040104011222.GA1433@furrr.two14.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55220 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264892AbUADCFB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jan 2004 21:05:01 -0500
In-Reply-To: <20040104011222.GA1433@furrr.two14.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: maney@pobox.com
Cc: Martin Maney <maney@two14.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 04 of January 2004 02:12, Martin Maney wrote:
> Okay, by now I have 2.4.23 installed, and with that version (and booting
> from a drive not connected to the Promise controller, a mirror pair on
> a 3ware controller, in fact) I no longer seem to be able to recreate
> the corruption that was previously so repeatable.  The autotune
> parameter makes no difference: it just works.
>
> If this issue is still of interest (ie, it's just by luck that .23
> works), I can do further testing for a while, but the drive that's on
> the Promise will be getting repurposed sooner or later.

I see nothing in 2.4.23 which can explain this.
Probably if you boot from Promise you will see corruption again.

--bart

