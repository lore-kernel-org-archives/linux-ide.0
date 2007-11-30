From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
 driver
Date: Fri, 30 Nov 2007 13:17:22 +0300
Message-ID: <474FE332.8080103@ru.mvista.com>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain> <20071127212222.GB10829@lixom.net> <200711272233.00456.arnd@arndb.de> <20071128154904.GA20722@localhost.localdomain> <474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:13072 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750733AbXK3KRL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 05:17:11 -0500
In-Reply-To: <20071129005440.GA2235@zarina>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbou@mail.ru
Cc: avorontsov@ru.mvista.com, Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

Anton Vorontsov wrote:

> Remaining question: any preferred name for that property? pio-mode okay?
> It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.

    I've already suggested "generic". A name "simple" also comes to my mind.

WBR, Sergei
