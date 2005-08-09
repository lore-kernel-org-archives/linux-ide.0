From: Mark Lord <liml@rtr.ca>
Subject: Re: libata for SATA HDs.
Date: Tue, 09 Aug 2005 16:04:12 -0400
Message-ID: <42F90C3C.6010809@rtr.ca>
References: <42EEA9D5.5080304@superbug.demon.co.uk>	 <42F8B264.5010706@rtr.ca> <1123611529.28278.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:59908 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932562AbVHIUEN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 16:04:13 -0400
In-Reply-To: <1123611529.28278.12.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

Erik Slagter wrote:
> 
> Hmmm, hdparm -S indeed works now, but smartctl doesn't work yet :-(. I
> was silently hoping that would start working as well.

Smartctl wants the "-d ata" option set to speak to libata.

Cheers
