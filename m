From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 07 May 2006 14:14:08 +0200
Message-ID: <445DE490.4010005@vip.cybercity.dk>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero0.cybercity.dk ([212.242.40.52]:14839 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S932077AbWEGMMb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 08:12:31 -0400
In-Reply-To: <20060507043702.052e3f56.moritz-heiber@arcor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Moritz Heiber wrote:
> I'm using a ASRock 939Dual-SATA2 mainboard equipped with a JMD360 SATA
> controller chip. A Hitachi Deskstar 7K250 (HDT722516DLA380), which is
> supposed to support SATAII, is attached to the only available SATAII
> compliant socket using the correct cables. The harddrive is recognized
> correctly as SATAII device by the AMI BIOS (latest revision 1.8.0).
> 
> Currently, the drive only runs in SATA-mode at 1.5Gbps:
..snip..
> So I'm wondering, is it just me .. or might the driver actually do
> something wrong here? Could it be a mismatching PCI_ID?

You could try the config with MS, where AFAIK, it does SATA300 mode.
You could try skimming forums on ocworkbench.com for info, as this is 
kindof an asian homeforum, with JCM360 being designed by .tw Jmicron.

Whatever, it may or may not be worth too much trouble. I'm thinking 
JCM360 may have an unclear future, since AFAIK the later ULi chipsets 
have native SATA 300 support, and nVidia bought ULi, perhaps to produce 
entry level chipsets (according to press).
I was very interested in that same board, due to very good test results 
and features, but skipped it for the very JCM360 driver issue.
Being a dirt cheap board, you could spend on a separate selected SATA 
interface (to keep for the next board). The mobo certainly has enough 
PCIx slots for that.

What's you overall experience with the board, WRT stability/performance?

-- 
Kind regards,
Mogens Valentin

