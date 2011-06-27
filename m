From: Hubert Bailey <hbailey@marvell.com>
Subject: RE: decoding PMP errors with Marvel SATA controller
Date: Sun, 26 Jun 2011 18:58:06 -0700
Message-ID: <B9B10C29375C5B40A2D240808654F60E5EE470A68B@SC-VEXCH2.marvell.com>
References: <20110626070820.GC24867@merlins.org>
 <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
 <20110627000614.GA5362@merlins.org> <4E07DCF5.1090506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52820 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754911Ab1F0CC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2011 22:02:28 -0400
In-Reply-To: <4E07DCF5.1090506@pobox.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <mlord@pobox.com>, Marc MERLIN <marc@merlins.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Larry Li <lil@marvell.com>

Mark,

Typically the biggest issues are with the PMPs that have internal RAID controllers.  These parts do not follow the SATA spec when they are not in RAID mode.
 

-----Original Message-----
From: Mark Lord [mailto:mlord@pobox.com] 
Sent: Sunday, June 26, 2011 8:29 PM
To: Marc MERLIN
Cc: Tejun Heo; linux-ide@vger.kernel.org; Larry Li; Hubert Bailey
Subject: Re: decoding PMP errors with Marvel SATA controller

On 11-06-26 08:06 PM, Marc MERLIN wrote:
> Speaking of which, what sata chips are recommended nowadays for PMP 
> outside
> sil24 cards?

Well, sata_mv cards were once *the* best cards going for PMP.
Nowadays though, none of the chipsets I have here work with all of the PMPs I have here.

JMicron are the most common eSATA chips on motherboards, but even they have PMP troubles with Linux (but not with Windows).

So.. dunno.
--
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

-----
No virus found in this message.
Checked by AVG - www.avg.com
Version: 10.0.1388 / Virus Database: 1513/3728 - Release Date: 06/26/11