From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Sat, 16 Jun 2007 12:23:36 +0200
Message-ID: <4673BA28.2020106@effenberger.org>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:37332 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXFPKXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jun 2007 06:23:42 -0400
In-Reply-To: <4667D4F5.1060302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hi there,

we tested out two 600W Fortron PSUs, also tried a BIOS update. Didn't 
work out.

We also tried the jumper on the disks labelled SSP (Spread Spectrum 
Clocking), didn't work out out as well.

What seemed to help at least a little bit is to use the 12V connector on 
the board, that is normally dedicated for graphic cards.

The best test to reproduce the problem, according to a colleague also 
working on the machine, is a cat /dev/zero > zero.bin

Do you still think it is a PSU or hardware problem? Do you need more 
details/logs?

Thanks!
Florian
