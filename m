From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Promise SATAII150 TX4 or raidreconf broken
Date: Sun, 11 Sep 2005 12:38:47 +1000
Message-ID: <432398B7.5070909@eyal.emu.id.au>
References: <430E4AB0.2060600@eyal.emu.id.au> <4313E433.1080602@pobox.com>	<43223709.8090002@eyal.emu.id.au> <x3kfysdq846.fsf@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:43940 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932328AbVIKCiy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Sep 2005 22:38:54 -0400
In-Reply-To: <x3kfysdq846.fsf@Psilocybe.Update.UU.SE>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thorild Selen <thorild@Update.UU.SE>
Cc: linux-ide@vger.kernel.org

Thorild Selen wrote:
> If you search a bit in the linux-ide and linux-kernel mailing list
> archives, you will find that several people before have had problems
> with SATA150-TX4 and SATAII150-TX4 (see for example posts by Jim
> Ramsay, Joerg Sommrey and me).
> 
> You haven't reported of any error messages on the console or reported
> by dmesg -- can you check dmesg output?

No, no errors reported. This is why I wondered (as the subject says)
if the reaidreconf itself can be the problem.

I now have a short (26m) test that reproduces the problem. The
corruption is different for each run, so I would not think it is
raidreconf.

Maybe the TX4 has silent corruption? Or maybe raidreconf really has
a non-deterministic bug.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
