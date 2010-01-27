From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Wed, 27 Jan 2010 06:19:05 +0530
Message-ID: <aacba7e1001261649v6f5cc037h41adcf253b978386@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
	 <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
	 <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
	 <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:56050 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909Ab0A0AtI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 19:49:08 -0500
In-Reply-To: <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Rees <drees76@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

2010/1/27 David Rees <drees76@gmail.com>:
> So my concern is that you're proposing to black list NCQ for all users
> of those particular models of SSD when it's more likely at this point
> that it's a problem with your specific setup.

Yes, a valid concern. I guess I didn't delve more because it's working
fine on my copy of Windows 7 RC (on the same hardware) with no sign
of error logs and pretty much the same perf as Linux with NCQ forced off.

What I can do personally is plug in my SSD into my tablet PC sitting next
to me and do a few more tests and get back to you all - it could be a couple
of days. I know its still just one user (me) reporting though.

FYI I had posted on the manufacturer's website/forums (quite active with
a lot of owners) and got NO response indicating there aren't too many
Linux users with this model - again "can't prove a negative" sort of way.

In any case, the workaround (should anyone face this issue) is to simply
add " libata.force=noncq " to the kernel boot options.
