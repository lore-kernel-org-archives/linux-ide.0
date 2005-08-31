From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Wed, 31 Aug 2005 18:15:11 +0400
Message-ID: <4315BB6F.2050402@wasp.net.au>
References: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local> <x3k1x4akhog.fsf@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:23006 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S932515AbVHaOPe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2005 10:15:34 -0400
In-Reply-To: <x3k1x4akhog.fsf@Psilocybe.Update.UU.SE>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thorild Selen <thorild@Update.UU.SE>
Cc: linux-ide@vger.kernel.org

Thorild Selen wrote:
> allen@gist.net.au (Allen Bolderoff) writes:
>> However - this card/driver is known to break when using more than 1
>> drive at a time (ie accessing 2 or 3 drives at once) 
> 
> I only have experience with the SATA150 TX4 (which uses the same
> driver), but it quite obviously breaks somewhere between 2.6.10 and
> 2.6.11. Several people have been reporting problems with sata_promise,
> using several disks simultaneously with a kernel later than 2.6.10.

In one machine, I'm using 15 disks on 4 SATA150TX4 cards with 2.6.11.7 and have been now for over 4 
months.. it's working perfectly.. not so much as a glitch.

My other box is still running 2.6.10-pre10 with 12 disks on 3 SATA150TX4 cards and the same.. no 
glitches

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
