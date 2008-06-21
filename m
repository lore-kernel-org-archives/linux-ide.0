From: "Mark Miesfeld" <miesfeld@gmail.com>
Subject: Adding port multiplier support to a LLDD
Date: Sat, 21 Jun 2008 13:35:45 -0700
Message-ID: <5d74c5720806211335i12cd4764j2109703ab224b1cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:52138 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYFUUfq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 16:35:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6254083rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2008 13:35:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I wonder if someone could give me a broad outline of what is needed to
add port multiplier support to a low-level SATA device driver through
libata in a 2.6.26 kernel.

I'm working on a driver for a new SOC (460EX) that AMCC has.  The chip
has support for SATA and support for port multipliers through
command-based switching.

For our in-house validation boards I have the driver working on a
2.6.19 kernel and implemented the port multiplier support within the
driver itself since libata didn't yet have port multiplier support.

Our customer evaluation boards (Canyonlands) are using a 2.6.26
kernel.  Stefan Roese at DENX has ported the 2.6.19 driver to 2.6.26
but without port multiplier support.  In 2.6.26 the libata port
multiplier support looks pretty good, I was hoping I can add the
support to the 2.6.26 driver fairly easily by going through libata.

What basic steps should I take?

Thanks.

--
Mark Miesfeld
