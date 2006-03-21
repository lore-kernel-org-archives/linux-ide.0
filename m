From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: Gigabyte i-Ram cards
Date: Mon, 20 Mar 2006 20:09:58 -0700
Message-ID: <311601c90603201909m313b7d84hf51cb7a7e056fcb@mail.gmail.com>
References: <441F63E6.2090204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:8926 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751471AbWCUDJ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Mar 2006 22:09:59 -0500
Received: by zproxy.gmail.com with SMTP id 34so1237830nzf
        for <linux-ide@vger.kernel.org>; Mon, 20 Mar 2006 19:09:59 -0800 (PST)
In-Reply-To: <441F63E6.2090204@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 3/20/06, Jeff Garzik <jeff@garzik.org> wrote:
>
> While responding to email related to Bugzilla# 6163 [1], I took a look
> at the Gigabyte i-Ram[2]:  PCI card, where PCI only provides power to
> some DIMMs.  Data xfer to/from DIMMs via SATA cable.  So, at current
> prices[3] one can get a 1GB Solid State Disk for US$206:  US$153 for the
> card, and US$53 for 1GB pc2700 ddr.
>
> I'm impressed.  I ordered one to help debug BZ#6163, but I think these
> cards will help expose bugs in libata due to their high speed.  With
> these cards, we can push more data through libata than would normally be
> possible with a standard disk drive.
>
> I've seen these for PATA before, but this is the first inexpensive SATA
> SSD that I've seen.  Let's hope its not riddled with hardware bugs
> <crosses fingers>.

I'll see if I can get Maxtor to buy one for me, then I'll be able to
hook it up to a bus analyzer.
