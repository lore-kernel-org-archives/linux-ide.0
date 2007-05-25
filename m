From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.22-rc1-mm1: IDE compile error
Date: Thu, 24 May 2007 17:51:56 -0700
Message-ID: <4656332C.7080909@zytor.com>
References: <20070515201914.16944e04.akpm@linux-foundation.org>	<20070516185552.GA4086@stusta.de>	<200705240145.38055.bzolnier@gmail.com>	<20070524115549.01c0e1ca@the-village.bc.nu>	<4656284D.7080709@zytor.com>	<20070525011403.20e77ee7@the-village.bc.nu>	<46562B5A.2070008@zytor.com> <20070525013817.26061764@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:44556 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbXEYAyI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 20:54:08 -0400
In-Reply-To: <20070525013817.26061764@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> The question I'm asking is: do you think it's better to remove this from
>> hd.c, or do you think it's better to add it back boot code BIOS
>> detection (and take the risk of poking an ST-506 disk with legacy data
>> with parameters which may belong to another disk -- keep in mind this
>> can permanently damage an ST-506 disk)?
> 
> To set it up the user will have to know the parameters and have typed
> them into the BIOS (if it even has an option for it). I see no problem

Sorry, see no problem which way?  My concern here is with getting
incorrect data, not getting no data.  The BIOS probe amounts to pulling
data out of two tables (INT 0x41/0x46, corresponding to BIOS drives 0x80
and 0x81 -- the EDD 1.1 spec is quite specific that if implemented they
follow the BIOS drive numbers, not the ATA port addresses), and hoping
that they actually match the drives that hd.c uses.  That scares me,
since we're talking about old legacy data here.

I'm not concerned with what's easy, I'm concerned with what's the right
thing to do.

	-hpa

