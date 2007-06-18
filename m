From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 19:56:54 +0900
Message-ID: <467664F6.4060607@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org> <4675F84D.3060207@gmail.com> <46766208.1080305@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:35074 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760429AbXFRK5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 06:57:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2124495wah
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 03:56:59 -0700 (PDT)
In-Reply-To: <46766208.1080305@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Florian Effenberger wrote:
> Hi,
> 
>> The controller being ich8, I'm pretty sure it isn't a driver problem.
> 
> I think so, too. The Intel chipsets have shown to be very good in the past.
> 
>> Do the errors occur on all four drives?  Also, if things work after
>> speed is downgraded to 1.5Gbps, it doesn't really matter.  There's no
>> noticeable performance difference for single disk anyway.
> 
> Yes, they do occur on all drives, as far as I know. With 1.5Gbps, the
> error doesn't occur much as often and not under normal circumstances,
> only when doing a real hard stress test.

Hmmm... Can you use a separate PSU to power two of the four drives and
see what happens?  Just power up a PSU as directed in the following
webpage and connect two of the harddrives to the PSU.

  http://modtown.co.uk/mt/article2.php?id=psumod

> Would it make sense to downgrade to 1.5 Gbps via a boot option?

I don't know.  Till now all the problem cases have been isolated to a
specific controller / drive combination (sata_promise and newer seagate
drives) or hardware configuration problem (most of them being PSU
issues), so I don't think we need such option yet.  If you have a
problematic hardware which pukes on 3.0Gbps, libata should do the right
thing after complaining a bit which IMHO isn't too bad.

-- 
tejun
