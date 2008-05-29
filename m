From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on MacBook4,1: fail to startup in a certain situation
Date: Thu, 29 May 2008 21:56:28 +0900
Message-ID: <483EA7FC.9080306@gmail.com>
References: <20080528075106.F2C3D29C127@m02-blue.in.shared-server.net>	<20080528075747.A18A5114160@m03-blue.in.shared-server.net>	<483D1429.3080804@gmail.com>	<20080528092117.4A5177080E8@m04-blue.in.shared-server.net>	<483D6AF4.8000502@gmail.com>	<20080528225338.5FB121E0868@m06-blue.in.shared-server.net>	<483DF782.1050208@gmail.com>	<20080529011256.60F8ECC0F2@m01-blue.in.shared-server.net>	<483E0AAE.9000307@gmail.com>	<20080529034139.A766529C0D5@m02-blue.in.shared-server.net>	<483E4889.1070501@gmail.com>	<20080529084351.191F529C0D5@m02-blue.in.shared-server.net>	<483E72FA.60901@gmail.com> <20080529095945.EF8431E086F@m06-blue.in.shared-server.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:13998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbYE2M4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 08:56:35 -0400
Received: by rv-out-0506.google.com with SMTP id l9so4072468rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 05:56:34 -0700 (PDT)
In-Reply-To: <20080529095945.EF8431E086F@m06-blue.in.shared-server.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MATSUBAYASHI 'Shaolin' Kohji <shaolin@rhythmaning.org>
Cc: linux-ide@vger.kernel.org

MATSUBAYASHI 'Shaolin' Kohji wrote:
> At Thu, 29 May 2008 18:10:18 +0900,
> Tejun Heo wrote:
>> Just to confirm, it doesn't work w/ PIIX_FLAG_SIDPR?
> 
> No it doesn't work on my MacBook.
> I confirmed that the booting suspended (like always)
> with the patch w/ PIIX_FLAG_SIDPR.

Alright, will submit the patch for #upstream-fixes.

Thanks.

-- 
tejun
