From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Candidate for late revert ?
Date: Mon, 02 Jun 2014 21:11:52 -0400
Message-ID: <yq1sinm6bl3.fsf@sermon.lab.mkp.net>
References: <20140603000728.28fca8fe@www.etchedpixels.co.uk>
	<CA+55aFykTbMRKku1bDd_wHCjyD+Yf2v-B8-c+NKMZ0AnNkpVrw@mail.gmail.com>
	<yq138fm98in.fsf@sermon.lab.mkp.net>
	<20140603004520.GB19855@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24033 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaFCBMH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2014 21:12:07 -0400
In-Reply-To: <20140603004520.GB19855@htj.dyndns.org> (Tejun Heo's message of
	"Mon, 2 Jun 2014 20:45:20 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:

Tejun> The problem with that approach is that it's very likely that we
Tejun> won't be able to take advantage of that feature ever.

Well, maybe. Ubuntu just turned on discard by default (for better and
worse). Took a while to get here with unqueued trim but it doesn't look
like they've had too much fallout.

The problem with queued trim is that we're in the bootstrap phase,
vendors generally don't have anything to test it with. The ones I talk
to claim that it's not really working in Windows yet. So we're the only
ones that actually support it.

Tejun> That said, I wouldn't have any problem with applying blacklist
Tejun> liberally for devices which show any sign of issues.  If there
Tejun> isn't no definite confirmation from the vendor regarding what the
Tejun> issue was and which firmware fixes it, I think blacklisting the
Tejun> whole family of devices isn't a bad idea.

Yeah. The fun thing in this case is that Micron specifically issued this
firmware release to fix queued trim. And they did test with our code. As
did I. And yet something broke for users.

Tejun> So, let's keep blacklisting liberally for now.

OK. And how do you feel about making a disable/unqueued/queued sysfs
knob? I'd really like to make it easy for the drive vendors to test. And
if we liberally blacklist their firmware releases then we have
significantly raised the barrier for their testing. Because all of a
sudden they need to start mucking with kernel builds instead of booting
the latest $DISTRO Live CD.

-- 
Martin K. Petersen	Oracle Linux Engineering
