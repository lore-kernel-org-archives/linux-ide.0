From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 09 Aug 2009 15:47:07 -0400
Message-ID: <h5n93s$pnr$1@ger.gmane.org>
References: <h5kn9c$51r$1@ger.gmane.org>	<4A7DE735.6090409@gmail.com>	<h5krje$ec7$1@ger.gmane.org> <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41166 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbZHITrV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Aug 2009 15:47:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MaEMS-0005Vk-0k
	for linux-ide@vger.kernel.org; Sun, 09 Aug 2009 19:47:20 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 19:47:19 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 09 Aug 2009 19:47:19 +0000
In-Reply-To: <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 08/09/2009 12:58 PM, Alan Cox wrote:

>
> You need st_mod.ko loaded (scsi tape), and the newer modules for the hard
> disk controller (pata_xxxx) and it should appear as /dev/st0 just as it
> did before the old IDE people broke ide-scsi support.

Do you know which pata driver I need?

 From lspci:

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)

I want to get guess CONFIG_PATA_MPIIX.

Would you agree?

I'm also using 3 SATA drives.  Is it okay to mix PATA and SATA drivers?

Thanks,

Jim

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


