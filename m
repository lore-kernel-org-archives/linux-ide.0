From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
 non-ATAPI data commands
Date: Sat, 22 Aug 2009 12:10:25 -0400
Message-ID: <4A901871.7020206@garzik.org>
References: <4A71FE71.7040002@gmail.com> <4A8F88CC.1000406@gmail.com> <4A8FFA9A.2020904@rtr.ca> <4A8FFC8A.1000500@garzik.org> <4A900DE6.2020802@rtr.ca> <4A900E87.5060207@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37098 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbZHVQK1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Aug 2009 12:10:27 -0400
In-Reply-To: <4A900E87.5060207@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockrwd@gmail.com>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 08/22/2009 11:28 AM, Mark Lord wrote:
> Mmm.. I wonder if something like this patch might also be applicable
> to the sata_sil.c driver too?


Not AFAICT.  The 3112 has a Command Protocol Table inside the chip. 
Each command reads the ATA command protocol from that table.  The table 
is programmable (see section 10.3 of [1]), but not on a per-command 
basis.  The per-command PRD format is pretty much legacy IDE[2], and 
nothing like the modern FIS-based controllers.

	Jeff



[1] http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
[2] bmdma2 modifies the PRD format a bit, but it is not relevant to this 
thread
