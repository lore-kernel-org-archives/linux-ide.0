From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: don't enable port irq before handler is
 registered
Date: Wed, 16 Mar 2011 10:05:31 +0100
Message-ID: <20110316090531.GB31832@htj.dyndns.org>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
 <4D7EB9EB.8030807@gmail.com>
 <1300162840.2118.4.camel@kero>
 <20110315071937.GB8635@htj.dyndns.org>
 <1300200509.10827.27.camel@sakura.staff.proxad.net>
 <1300201422.10827.39.camel@sakura.staff.proxad.net>
 <20110315151931.GA17376@htj.dyndns.org>
 <1300224158.10827.52.camel@sakura.staff.proxad.net>
 <20110316090453.GA31832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36185 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab1CPJFf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2011 05:05:35 -0400
Received: by bwz15 with SMTP id 15so1322525bwz.19
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2011 02:05:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316090453.GA31832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maxime Bizon <mbizon@freebox.fr>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

On Wed, Mar 16, 2011 at 10:04:53AM +0100, Tejun Heo wrote:
>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> But just one nit.

Ooh, please also add

 Cc: stable@kernel.org

Thanks.

-- 
tejun
