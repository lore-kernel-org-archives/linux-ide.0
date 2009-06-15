From: Mark Lord <liml@rtr.ca>
Subject: Re: NCQ blacklist
Date: Mon, 15 Jun 2009 09:11:11 -0400
Message-ID: <4A36486F.5090500@rtr.ca>
References: <5cf1b7b10906141540k6336730ep93bba3d97fda7680@mail.gmail.com>	 <20090615000104.4c65548e@lxorguk.ukuu.org.uk> <5cf1b7b10906150319n6bf4c9f7s399613c44df45ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46851 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbZFONLL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Jun 2009 09:11:11 -0400
In-Reply-To: <5cf1b7b10906150319n6bf4c9f7s399613c44df45ca7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrea Bravetti <andreabravetti@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Andrea Bravetti wrote:
..
> hdparm -I still report NCQ as enabled and I don't know if it's a problem,
..

"hdparm -I" does no such thing.
It merely shows the maximum queue depth that the drive permits.

If you want to see what queue depth Linux is using for the drive,
then either look in sysfs, or let "hdparm -Q" do it for you.

Cheers
