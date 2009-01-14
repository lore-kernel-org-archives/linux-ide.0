From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 16:26:54 -0500
Message-ID: <496E589E.7090909@garzik.org>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36354 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757354AbZANV1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 16:27:00 -0500
In-Reply-To: <496E53DD.6040408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Harri Olin wrote:
> I still see timeouts only on 4 lower ports where disk has also been 
> connected to port +4. i.e. if port 7 is empty, port 3 will work just 
> fine. I just would like to see some confirmation that others are seeing 
> this same kind of behavior.


hmmmm, that is quite interesting.   That seems to indicate something 
related to the dual-HC mechanism (8-port cards are really two 4-port 
chips internally)...

	Jeff



