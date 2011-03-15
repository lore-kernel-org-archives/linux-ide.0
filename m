From: Tejun Heo <htejun@gmail.com>
Subject: Re: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Tue, 15 Mar 2011 16:19:31 +0100
Message-ID: <20110315151931.GA17376@htj.dyndns.org>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
 <4D7EB9EB.8030807@gmail.com>
 <1300162840.2118.4.camel@kero>
 <20110315071937.GB8635@htj.dyndns.org>
 <1300200509.10827.27.camel@sakura.staff.proxad.net>
 <1300201422.10827.39.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35110 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab1COPUR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 11:20:17 -0400
Received: by fxm17 with SMTP id 17so674228fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Mar 2011 08:20:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300201422.10827.39.camel@sakura.staff.proxad.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maxime Bizon <mbizon@freebox.fr>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

On Tue, Mar 15, 2011 at 04:03:42PM +0100, Maxime Bizon wrote:
> 
> On Tue, 2011-03-15 at 15:48 +0100, Maxime Bizon wrote:
> 
> > no it doesn't, but this one does:
> 
> sorry it does not compile, missing ')', but actually works
> 
> I will send a proper patch if you agree with this solution

Hmm... I don't really like INITIALIZING being tested there.  It's much
more cumbersome to explain.  Can you please change ata_port_alloc() to
set pflags to INITIALIZING|FROZEN?  And add a comment in ahci briefly
noting why the test is necessary?

Thanks.

-- 
tejun
