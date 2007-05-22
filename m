From: Jeff Garzik <jeff@garzik.org>
Subject: Re: JMicron JMB361 sporadically failing to initialize from at least
 2.6.18.4 to 2.6.22-rc2
Date: Mon, 21 May 2007 20:56:17 -0400
Message-ID: <46523FB1.9000000@garzik.org>
References: <76366b180705211748u670e3084j8df5246eca82a925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47205 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756965AbXEVA4T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 20:56:19 -0400
In-Reply-To: <76366b180705211748u670e3084j8df5246eca82a925@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> I have a Gigabyte GA-965P-DQ6 motherboard which has onboard Intel ICH8
> raid as well as a "Gigabyte" (rebranded JMicron) chipset for 2
> separate SATA ports. When I boot the machine, it completely
> sporadically fails to initialize the JMB361 chipset which it detects,
> claiming "dma_base is invalid". When it works (~20% of the time), it
> will correctly detect the chip and all drives connected to it. It
> feels like a race condition..

What happens when you disabled the old-IDE driver, and use libata?

	Jeff



