From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sil4723 on ata2 - ICH7 - Timeouts - Suspend to RAM
Date: Wed, 02 Jan 2008 19:40:07 +0900
Message-ID: <477B6A07.5030408@gmail.com>
References: <1182090097.3108.6.camel@little.lethalwp>	 <46761D02.8090106@gmail.com> <1199259632.3066.6.camel@little.lethalwp>	 <477B4458.2070407@gmail.com> <1199269573.3357.3.camel@little.lethalwp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:40364 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbYABKkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 05:40:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5221636rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 02:40:13 -0800 (PST)
In-Reply-To: <1199269573.3357.3.camel@little.lethalwp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean-Yves Simon <lethalwp@tiscali.be>
Cc: linux-ide@vger.kernel.org

Jean-Yves Simon wrote:
> This mail to confirm that the sil4723 sata "bridge" using 2.6.24-rc6
> now:
>  - has no timeouts anymore on boot & on first suspend
>  - support a suspend to ram sleeping mode

Note: This is about the dreaded ASUS P5W-DH w/ on board PMP, which
wasn't fixed by PMP support but by adding a whole lot of ugly quirks to
work around dumbass single disk emulation mode of the 4723.  Anyways,
it's good to hear all that ugliness does some good.  :-)

-- 
tejun
