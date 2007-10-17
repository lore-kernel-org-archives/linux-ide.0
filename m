From: "Ip, Clarence" <CIP@harris.com>
Subject: FW: LIBATA issue with SATA drive
Date: Wed, 17 Oct 2007 12:13:17 -0400
Message-ID: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mlbe2k1.cs.myharris.net ([137.237.90.88]:16538 "EHLO
	mlbe2k1.cs.myharris.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760069AbXJQQfk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 12:35:40 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello Tejun,

I've CC'd the mailing list, but couldn't find Torsten's e-mail. Do you
have any suggestions on where I should look for this problem? Did the
boot-up log suggest anything to you?

- Clarence


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Wednesday, October 17, 2007 4:32 AM
To: Ip, Clarence
Subject: Re: LIBATA issue with SATA drive

Ip, Clarence wrote:
> Hello Tejun,
> 
> I'm using the 2.6.22 sources with a Sii3132 SATA controller and a
> Seagate HDD. What I've noticed is that it often fails to boot with
this
> configuration. Warm boots appear to always fail while cold boots
> (power-cycles) fail maybe 20%-50% of the time. Here's a log from my
last
> attempt:

Hmmm... We had a similar report against -mm kernel but that case seemed
like newly introduced with recent -mm changes.  Do you mind cc'ing the
other reporter and linux-ide@vger.kernel.org mailing list?

Thanks.

-- 
tejun
