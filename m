From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
Date: Wed, 29 Nov 2006 14:27:11 -0500
Message-ID: <456DDF0F.6080501@rtr.ca>
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com> <456DD70D.1050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:48913 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S967581AbWK2T1O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Nov 2006 14:27:14 -0500
In-Reply-To: <456DD70D.1050808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Berck E. Nash wrote:
> Tejun Heo wrote:
>
>> Then, a series of obsolete STANDBY failures.  Who's issuing these 
>> commands?  It's not libata, libata uses STANDBY (0xe2).  Is it some 
>> kind of gentoo thing?
> 
> Nope, Debian/Unstable.

Most probably my hdparm utility.  It first tries the old STANDBY command,
then tries the newer one if the first one fails.  This should not cause
anybody's system to lock up.

Cheers
