From: Theodore Tso <tytso@MIT.EDU>
Subject: Bug#582275: ext3 filesystem corruption on md RAID1 device
Date: Fri, 18 Jun 2010 07:09:06 -0400
Message-ID: <EE6E2E73-39B6-4D90-B2E2-3BA2C1DD4E91@mit.edu>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net> <20100520143039.GC16634@thunk.org> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B794C8@GVW1115EXC.americas.hpqcorp.net> <20100527201234.GE3576@quack.suse.cz> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3638@GVW1115EXC.americas.hpqcorp.net> <20100531205547.GH5334@quack.suse.cz> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3DCB@GVW1115EXC.americas.hpqcorp.net> <20100601102240.GA4275@quack.suse.cz> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F4A113B66@GVW1115EXC.americas.hpqcorp.net>
Reply-To: Theodore Tso <tytso@MIT.EDU>, 582275@bugs.debian.org
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-rc=glddbr-debian-bugs-rc=gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.582275.B582275.127685936028728@bugs.debian.org>
In-Reply-To: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F4A113B66@GVW1115EXC.americas.hpqcorp.net>
List-Post: <mailto:debian-bugs-rc@lists.debian.org>
List-Help: <mailto:debian-bugs-rc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=unsubscribe>
To: "Buehl, Reiner" <reiner.buehl@hp.com>
Cc: Jan Kara <jack@suse.cz>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "582275@bugs.debian.org" <582275@bugs.debian.org>
List-Id: linux-ide@vger.kernel.org


On Jun 18, 2010, at 3:12 AM, Buehl, Reiner wrote:

> Hi Jan,
>=20
> I tried for a while with alternate hardware and the original =
controller but the error did never happen again. I think your idea of a =
bug in e2fsck's handling of multiply claimed blocks is the only =
explanation: Maybe during a corruption long ago a number of multiply =
claimed blocks existed and where reduced with each reboot. Is this =
possible? How can this be fixed?
>=20

It could be an e2fsck bug, or it could be a hardware issue.  In my =
experience, every time
I've tried digging into problems with e2fsck -fy not fixing all problems =
in a single
pass, it's been a hardware problem.  That being said, multiply claimed =
blocks is
something that isn't exercised that much, so it's *possible* that it is =
an e2fsck bug.

I really would need a reproducible test case before I could do anything =
though.

 -- Ted
