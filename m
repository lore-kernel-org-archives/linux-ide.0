From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 17:08:25 -0500
Message-ID: <496E6259.3000502@rtr.ca>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E589E.7090909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41374 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045AbZANWI1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 17:08:27 -0500
In-Reply-To: <496E589E.7090909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Harri Olin <harri.olin@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Jeff Garzik wrote:
> Harri Olin wrote:
>> I still see timeouts only on 4 lower ports where disk has also been 
>> connected to port +4. i.e. if port 7 is empty, port 3 will work just 
>> fine. I just would like to see some confirmation that others are 
>> seeing this same kind of behavior.
> 
> 
> hmmmm, that is quite interesting.   That seems to indicate something 
> related to the dual-HC mechanism (8-port cards are really two 4-port 
> chips internally)...
..

Yup.  As I just noted on the redhat bugzilla entry,
this bug only bites when drives are attached to *both*
the lower and upper halves of the chip.

The second patch fixes that problem.
Once we hear back again from some affected users,
I'll reissue it for upstream/backstream.

Thanks
