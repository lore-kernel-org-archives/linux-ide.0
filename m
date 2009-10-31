From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Sat, 31 Oct 2009 09:56:26 -0400
Message-ID: <4AEC420A.9030502@rtr.ca>
References: <20091026162011.GA3289@frolo.macqel> <4AE64031.5060105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55940 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794AbZJaN4a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Oct 2009 09:56:30 -0400
In-Reply-To: <4AE64031.5060105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Philippe De Muyter <phdm@macqel.be>, linux-ide@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Robert Hancock wrote:
..
> This has come up before:
> 
> http://marc.info/?l=linux-ide&m=123064513313466&w=2
> 
> I think this timeout should not even exist. libata has no such timeout 
> (only the overall command completion timeout), and I can't find any 
> reference in current ATA specs to the device being required to raise DRQ 
> in any particular amount of time.
..

The reason for the original (20ms, then 50ms) timeout was this text
from the ATA1 specification, long since outdated:

   -  Upon receipt of a Class 3 command, the drive sets BSY within 400 nsec,
      sets  up the sector buffer for a write operation, sets DRQ within 20
      msec, and clears BSY within 400 nsec of setting DRQ.

Cheers
