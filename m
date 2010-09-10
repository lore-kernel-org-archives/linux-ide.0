From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil boot problems with kernel 2.6.35 and current git
Date: Fri, 10 Sep 2010 16:39:48 +0200
Message-ID: <4C8A4334.4030808@kernel.org>
References: <20100908182651.GA32114@seek.priv> <4C88F69E.6070000@kernel.org> <4C8A210C0200007800015648@vpn.id2.novell.com> <4C8A40EC.3090606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55836 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005Ab0IJOkv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2010 10:40:51 -0400
In-Reply-To: <4C8A40EC.3090606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugo Antunes <hugo.antunes@gmail.com>
Cc: Jan Beulich <JBeulich@novell.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, dieter@plaetinck.be, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gianluca <gianluca@sottospazio.it>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

Hello,

On 09/10/2010 04:30 PM, Hugo Antunes wrote:
> Following the list this pasts days as a sysadmin, building a big machine
> with 45 sata2 disks (WD green 1.5TB), Sil3124 4 ports sata2 with 9 port
> multipliers with 5 each also from Silicom image.
> 
> This machine should smoke but it doesn't, attached is the dmesg dump
> where it is possible to see the enourmous ammount of hard and soft
> resets.Using Ubuntu/server 10.4 2.6.32-25-server x86_64, been
> questioning if this patch could make me have better i/o, sata link
> allways at half speed, going to build a debian/ubuntu kernel image
> with the patch, if anyone has a link for a deb image with this
> patch..apreciated.

Please start a new thread.  sata_sil and sata_sil24 don't have much in
common.  Also, it seems you have posted the wrong dmesg.  There's no
sil24 probing going on in the log.

Thanks.

-- 
tejun
