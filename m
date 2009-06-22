From: Frans Pop <elendil@planet.nl>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Mon, 22 Jun 2009 17:16:04 +0200
Message-ID: <200906221716.05983.elendil@planet.nl>
References: <200906211446.38598.elendil@planet.nl> <200906221604.17915.elendil@planet.nl> <200906221639.52205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:64798 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854AbZFVPQE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 11:16:04 -0400
In-Reply-To: <200906221639.52205.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 22 June 2009, Bartlomiej Zolnierkiewicz wrote:
> I promised to look into it but I still need a identify block content to
> tell more (you can add #define DEBUG to the ide-probe.c so we will get
> id before and after changing of transfer mode settings):

probing for hdd: present=0, media=32, probetype=ATA
probing for hdd: present=0, media=32, probetype=ATAPI
hdd: dumping identify data
c085 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 3841
2045 2020 2020 4443 522d 4d4f 3520 5836
412f 484b 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 000f 0000 0003 0002 0200 0000 0000
0000 0000 0000 0000 0000 0000 0701 0701
0300 7800 7800 5802 7800 0000 0000 0000
0000 0000 0000 3030 3030 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0700 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
