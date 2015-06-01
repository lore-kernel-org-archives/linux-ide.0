From: Ian Campbell <ijc@debian.org>
Subject: Re: QNAP TS-419: sata_mv fails to initialise with "can't set global
 reset"
Date: Mon, 01 Jun 2015 22:07:37 +0100
Message-ID: <1433192857.5748.288.camel@debian.org>
References: <1433068534.5748.276.camel@debian.org>
	 <20150601025050.GB11354@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from benson.vm.bytemark.co.uk ([212.110.190.137]:56083 "EHLO
	benson.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbFAVHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2015 17:07:42 -0400
In-Reply-To: <20150601025050.GB11354@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Mon, 2015-06-01 at 04:50 +0200, Andrew Lunn wrote:
> You might also want to try 
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/416589
> 
> In particular the first patch.

That did the trick, thanks!

Ian.


