From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Mon, 26 Feb 2007 02:41:22 +0900
Message-ID: <45E1CA42.6070707@gmail.com>
References: <20070205080128.GH1625@htj.dyndns.org> <20070225132945.44299b0c@lxorguk.ukuu.org.uk> <45E19AE7.2020206@gmail.com> <200702251839.36205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:29584 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965031AbXBYRl1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Feb 2007 12:41:27 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1111738wxd
        for <linux-ide@vger.kernel.org>; Sun, 25 Feb 2007 09:41:26 -0800 (PST)
In-Reply-To: <200702251839.36205.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Bartlomiej Zolnierkiewicz wrote:
> Why can't libata do the right thing and just send IDENTIFY command
> to the slave device first?

That's my plan B.  I'm just not sure whether it would do any good, would it?

-- 
tejun
