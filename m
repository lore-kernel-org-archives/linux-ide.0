From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Thu, 30 Aug 2007 23:34:34 +0200
Message-ID: <46D737EA.6010707@gmail.com>
References: <200708212149.12912.jopan@alumni.uv.es>	 <20070822162312.GG9412@csclub.uwaterloo.ca>	 <46CC6A2F.5000406@gmail.com> <200708280044.34475.jopan@alumni.uv.es>	 <46D455DB.8000800@gmail.com>	 <Pine.LNX.4.64.0708302130210.24730@fbirervta.pbzchgretzou.qr>	 <46D7231B.3080807@gmail.com> <87f94c370708301416j2a7c000bscbaef593af004010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:37952 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbXH3Vke (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 17:40:34 -0400
In-Reply-To: <87f94c370708301416j2a7c000bscbaef593af004010@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, =?ISO-8859-15?Q?Jos=E9_Lu?= =?ISO-8859-15?Q?is_Pati=F1o_Andr=E9s?= <jopan@alumni.uv.es>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 08/30/2007 11:16 PM, Greg Freemyer wrote:

> On 8/30/07, Rene Herman <rene.herman@gmail.com> wrote:

>> Well -- the world where ATA, SCSI, USB, Firewire and what have you are
>> low-level drivers to a unifying storage layer is under non too obscure
>> definitions sort of not non-wonderful...
>>
> 
> USB / Firewire / FC / iSCSI are all SCSI transports and fit within the
> SCSI subsystem by design.
> 
> ie. Just like ethernet, DSL, T-1, etc can all carry IP traffic with no
> conceptual conflict, many media by design carry SCSI traffic.
> 
> The PATA and SATA physical layer typically carry ATA commands and
> having them tied into the SCSI stack is an aberration that I hope will
> be eliminated some day.
> 
> ATAPI is an exception.  Not sure where that would end up in a perfect world.

As said, if you make a bit of an effort to view the former SCSI stack as a 
unified storage midlayer the abberation becomes less abberational (if that's 
a word).

Real SCSI, the other SCSI transports and ATAPI would just use more of the 
common mid-layer than P/SATA would. I'd expect the way forward would be to 
just refactor things until someone notices that drivers/scsi is the wrong 
place for sd.c and sr.c and moves them to drivers/block or whereever.

Practically, the PATA driver gives me (almost) the same throughput as the 
old IDE driver does, and given that I need the former SCSI stack _anyway_ 
for my external USB harddrive, I don't see a pressing need to carry along 
yet another storage stack for my harddrive.

Rene.


