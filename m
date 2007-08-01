From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Boot fails on Intel SATA controller
Date: Wed, 1 Aug 2007 11:39:49 -0300
Message-ID: <20070801113949.474443e5@localhost>
References: <080120071418.11784.46B09645000B42BF00002E082200735834CE05040A05@comcast.net>
	<46B09A57.50806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:57260 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbXHAOj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 10:39:56 -0400
In-Reply-To: <46B09A57.50806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Quel Qun <kelk1@comcast.net>, linux-ide@vger.kernel.org

Em Wed, 01 Aug 2007 23:36:07 +0900
Tejun Heo <htejun@gmail.com> escreveu:

| Quel Qun wrote:
| >  -------------- Original message ----------------------
| > From: Tejun Heo <htejun@gmail.com>
| >> Hello,
| >>
| >> Luiz Fernando N. Capitulino wrote:
| >>>  Hi there,
| >>>
| >>>  A Mandriva user is reporting that his machine hangs while booting
| >>> kernels 2.6.22.1 and 2.6.23-rc1.
| >>>
| >>>  But boots fine with 2.6.21.
| >>>
| >>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
| >>> ata1.00: qc timeout (cmd 0x27)
| >>> ata1.00: ata_hpa_resize 1: hpa sectors (0) is smaller than sectors (781422768)
| >>> ata1.00: ATA-7: HDS724040KLSA80, KFAOA20N, max UDMA/133
| >>> ata1.00: 781422768 sectors, multi 8: LBA48
| >>> ata1.00: failed to set xfermode (err_mask=0x40)
| >>> ata1: failed to recover some devices, retrying in 5 secs
| >> What happens after this?
| >>
| > It basically retries a few times, then fails to boot. Here is a more complete log with 2.6.23-rc1:
| 
| Does the attached patch change anything?

 Quel Qun, if you can't patch the kernel for some reason I can
generate a Mandriva kernel package with the patch for you.

 Just ask.

-- 
Luiz Fernando N. Capitulino
