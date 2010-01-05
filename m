From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Tue, 5 Jan 2010 17:44:04 +0000
Message-ID: <20100105174403.GB30868@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B428FF5.7040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56707 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab0AERoR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 12:44:17 -0500
Content-Disposition: inline
In-Reply-To: <4B428FF5.7040702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 07:03:49PM -0600, Robert Hancock wrote:
> I don't think it is. From ATA-8 APT:

Now go and look at the drive state diagram rather than the host
state diagram.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
