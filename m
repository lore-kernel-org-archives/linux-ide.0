From: Tejun Heo <tj@kernel.org>
Subject: Re: using sata_sil24 10.4 2.6.32-25-server x86_64
Date: Fri, 10 Sep 2010 17:49:44 +0200
Message-ID: <4C8A5398.1010806@kernel.org>
References: <4C8A4BD6.6090206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47038 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540Ab0IJPtt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2010 11:49:49 -0400
In-Reply-To: <4C8A4BD6.6090206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugo Antunes <hugo.antunes@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 09/10/2010 05:16 PM, Hugo Antunes wrote:
> Greetings,
> 
> Following the list this pasts days as a sysadmin, building a big machine
> with 45 sata2 disks (WD green 1.5TB), Sil3124 4 ports sata2 with 9 port
> multipliers with 5 each also from Silicom image.
>  
> This machine should smoke but it doesn't, attached is the dmesg dump
> Using Ubuntu/server 10.4 2.6.32-25-server x86_64 using sata_sil24
> disks and bios controlers supports Western Digital Green drivers or
> any other kind of disks, sort of bug or simply a sysctl value.  will
> provide more logs if needed, 2.6.36-rc3 ?

The errors are across different drives.  Most reported error statfus
are bogus.  They are just copy of the command TF.  The ones which are
valid are...

[ 6214.444011] ata8.01: cmd 60/70:68:88:9c:41/00:00:29:00:00/40 tag 13 ncq 57344 in
[ 6214.444012]          res 41/84:00:88:9c:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>

[ 6215.402708] ata8.04: cmd 60/28:60:a8:b0:41/00:00:29:00:00/40 tag 12 ncq 20480 in
[ 6215.402709]          res 41/84:00:a8:b0:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>

[ 6216.016810] ata8.02: cmd 60/40:08:90:b7:41/00:00:29:00:00/40 tag 1 ncq 32768 in
[ 6216.016811]          res 41/84:00:90:b7:41/00:00:29:00:00/40 Emask 0x410 (ATA bus error) <F>

and so on.  They all indicate that the drives are seeing CRC errors on
the link.  If you boot w/ libata.force=1.5Gbps, does it make any
difference?  I suppose the drives are connected via backplane, right?
Faulty backplanes aren't too uncommon so if possible trying to connect
some other way would be a good idea.  Also, if you remove some, say,
half of the drives, does it make any difference?

Thanks.

-- 
tejun
