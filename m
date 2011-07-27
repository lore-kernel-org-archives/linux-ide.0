From: Borislav Petkov <bp@amd64.org>
Subject: Re: Machine check exception
Date: Wed, 27 Jul 2011 19:03:09 +0200
Message-ID: <20110727170309.GB26923@gere.osrc.amd.com>
References: <4E2FF0EC.2020704@gmail.com>
 <20110727130319.GA26923@gere.osrc.amd.com>
 <4E302F6C.3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s15228384.onlinehome-server.info ([87.106.30.177]:51947 "EHLO
	mail.x86-64.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab1G0RDB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2011 13:03:01 -0400
Content-Disposition: inline
In-Reply-To: <4E302F6C.3@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "F. P. Beekhof" <fpbeekhof@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On Wed, Jul 27, 2011 at 05:31:56PM +0200, F. P. Beekhof wrote:
> $ sudo rdmsr 0xc001001f
> 8
> 
> Is there anything else I can do ?

Ok, I'd like you to try something out:

Boot into runlevel 1: you need this because you get the MCE before
you've done starting apache. For that, add a "1" to your kernel command
line and boot. When you get the prompt, type in your root pwd and do

wrmsr 0xc001001f $(( $(rdmsr -u 0xc001001f) | (1 << 20) ))

Then do

rdmsr -x 0xc001001f

to verify that the write has succeeded. It should say

0x00100008.

then exit the prompt to continue to runlevel 2 to see whether this
setting fixes your MCE issue.

This is for now,
thanks.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
GM: Alberto Bozzo
Reg: Dornach, Landkreis Muenchen
HRB Nr. 43632 WEEE Registernr: 129 19551
