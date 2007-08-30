From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Thu, 30 Aug 2007 21:31:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708302130210.24730@fbirervta.pbzchgretzou.qr>
References: <200708212149.12912.jopan@alumni.uv.es> <20070822162312.GG9412@csclub.uwaterloo.ca>
 <46CC6A2F.5000406@gmail.com> <200708280044.34475.jopan@alumni.uv.es>
 <46D455DB.8000800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:44224 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbXH3TbP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 15:31:15 -0400
In-Reply-To: <46D455DB.8000800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: =?ISO-8859-15?Q?Jos=E9_Luis_Pati=F1o_Andr=E9s?= <jopan@alumni.uv.es>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


On Aug 28 2007 19:05, Rene Herman wrote:
>> Okay Rene, I activated SCSI CD-ROM support in kernel config and now all
>> works again. It's strange, because I never used this option to get my DVD
>> device on.
>
> Sheesh. How could anyone _not_ understand you need SCSI CD-ROM support for your
> IDE DVD-RW drive...

Welcome to the wonderful world of SCSIfying ATA. (Don't talk about 
ATAPI, USB/Firewire, it's a different matter.)


	Jan
-- 
