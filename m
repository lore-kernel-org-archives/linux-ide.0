From: Tejun Heo <htejun@gmail.com>
Subject: Re: RE :sata_sil + UDMA CRC errors
Date: Tue, 6 Sep 2005 20:56:59 +0900
Message-ID: <20050906115659.GA16865@htj.dyndns.org>
References: <1126006398.3097.9.camel@m00>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:17226 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964831AbVIFL5G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 07:57:06 -0400
Received: by zproxy.gmail.com with SMTP id 13so992230nzn
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2005 04:57:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1126006398.3097.9.camel@m00>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "lbattraw@insightbb.com" <lbattraw@insightbb.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "Carlos.Pardo@siliconimage.com" <Carlos.Pardo@siliconimage.com>, Yuri Kirsanov <flash@rccb.ru>, Paul Taylor <Paul.Taylor@siliconimage.com>

On Tue, Sep 06, 2005 at 06:33:18PM +0700, Alexander Shaposhnikov wrote:
> 
> Hi again.
> 
> Some time ago i reported bugs in sata_sil driver.
> 
> It seems that latest kernel 2.6.13-git4 solved all the problems for my Seagate SATA drive.
> However, nothing has changed with Samsung drive, i am still getting alot of CRC errors.
> There is probably some unknown compatibility issue with Samsung drives and sil3114 controller.
> 
> If somebody is interested in this, i can provide more detailed information.

 Hello, Alexander.

 AFAIK, there has been no change since you reported the problem last
time which can affect your CRC errors.  I think what you're seeing is
a hardware problem - be it the controller, cable or whatever.
Transfer errors due to hardware problems can come and go away with
silly silly reasons.  For example, placing SATA cables differently
inside your case can make CRC errors go away (especially because SATA
cables are not shielded/twisted).

 The thing is that CRC errors can be ignored and commands can be
retried without much performance hit - the head is probably already
there and only data needs to be transferred again.  I believe that's
what's going on when you're on Windows.

  Also, you've previously mentioned that you see much less errors with
my m15w workaround applied.  That's not because the workaround does
something to alleviate transfer errors.  All it does is reducing
number of commands issued, thus reducing number of errors too.

 I have both Segate and Samsung drives and both work happily with my
3112 (not 3114 but still...) controller.  From what you're reporting
(disappearance of CRC errors on a drive without clear reasons), I'm
very inclined to think that you have a faulty hardware.

 To verify, can you please try again the kernel you used when
initially reporting this (2.6.12-rc6, right?) and see if it still
produces CRC errors on the Seagate drive?

 Thanks.

-- 
tejun
