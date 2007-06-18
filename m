From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 20:30:21 +0900
Message-ID: <46766CCD.9040505@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org> <4675F84D.3060207@gmail.com> <46766208.1080305@effenberger.org> <467664F6.4060607@gmail.com> <46766C71.6030607@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:36792 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbXFRLa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 07:30:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2133931wah
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 04:30:25 -0700 (PDT)
In-Reply-To: <46766C71.6030607@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Florian Effenberger wrote:
>> I don't know.  Till now all the problem cases have been isolated to a
>> specific controller / drive combination (sata_promise and newer seagate
>> drives) or hardware configuration problem (most of them being PSU
>> issues), so I don't think we need such option yet.  If you have a
>> problematic hardware which pukes on 3.0Gbps, libata should do the right
>> thing after complaining a bit which IMHO isn't too bad.
> 
> So, loss of data or data corruption can't occur, even when we have to
> wait until the speed is limited?

Nope, there's nothing to worry about.

-- 
tejun
