From: thorild@Update.UU.SE (Thorild Selen)
Subject: Re: Promise SATAII150 TX4: strange disk ordering
Date: Wed, 31 Aug 2005 16:33:16 +0200
Message-ID: <17173.49068.154562.170503@Psilocybe.Update.UU.SE>
References: <EC70EFBFB6977A478BEB386684E8A7420CE728@pwfsbs01.pwf.local>
	<x3k1x4akhog.fsf@Psilocybe.Update.UU.SE>
	<4315BB6F.2050402@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elvira.ekonomikum.uu.se ([130.238.164.5]:64747 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S964825AbVHaOdu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Aug 2005 10:33:50 -0400
In-Reply-To: <4315BB6F.2050402@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell writes:
 > In one machine, I'm using 15 disks on 4 SATA150TX4 cards with
 > 2.6.11.7 and have been now for over 4 months.. it's working
 > perfectly.. not so much as a glitch.

Is this a single-processor system without hyperthreading or the like?
In that case, it could be that the problem only appears on SMP/HT
systems, which would be interesting to know.

(I was hit by the bug on a single-processor Xeon system, but with HT
enabled. I never thought of testing if disabling HT would make the bug
disappear or not. And now that the system is up and running again, I
don't really have the possibility to experiment with it.)

If you have partitions on different devices that you can spare and
feel a little risky, you can try running badblocks -w (WARNING: this
will destroy any data on the disk/partition!) on several disks
simultaneously.  That appears to be the simplest way to quickly
reproduce the bug.


Thorild Sel=E9n
Datorf=F6reningen Update / Update Computer Club, Uppsala, SE
