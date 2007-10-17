From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Wed, 17 Oct 2007 21:21:28 +0200
Message-ID: <471660B8.7080309@how.dk>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepc.post.tele.dk ([195.41.46.237]:56573 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXJQTVc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 15:21:32 -0400
In-Reply-To: <1785297944.20071017170444@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Alexander Sabourenkov <screwdriver@lxnt.info>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi,

MisterE wrote:
> Tonight i will try the Asus motherboard with 1 drive and much I/O. And
> i will create a new array which takes 7 hours. But how often/hours do
> you need to try something to prove it does not fail :P

On one box I had problems with the SATA300 TX4 using 2.6.21 through 
2.6.22 (different versions). I have 4x500GB Seagate ES SATA drives 
connected. The system would run fine, but when put to a stress - i.e. 
loaded on all sata ports one or two ports would fail - one after the 
other. I have _always_ been able to make it fail doing:

dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

The ports would freeze before running long - e.g. in less than an hour.

This can be done without even starting the array (mdadm). Therefore no 
data corruption will happen.

The above issue was fixed by updating to vanilla 2.6.23.1.

Until then I have been running with 2.6.21-rc2 with a Mikael Petterson 
patch to force the SATA to 1.5Gbps (this could possibly be accomplished 
by jumpers on the drives as well - but I didn't try that).

I have another system (Dell PE1800 = different from the above) running 
24x7 using vanilla linux 2.6.19.5. This system has been running without 
hickups for more than a year (current uptime 135 days).


Hope this helps,

Best regards,

Peter
