From: Theodore Tso <tytso@MIT.EDU>
Subject: Bug#582275: ext3 filesystem corruption on md RAID1 device
Date: Fri, 18 Jun 2010 07:25:18 -0400
Message-ID: <BB158359-CCDB-49E6-975D-B2A9F3062088@mit.edu>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net> <20100520143039.GC16634@thunk.org> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B794C8@GVW1115EXC.americas.hpqcorp.net> <20100527201234.GE3576@quack.suse.cz> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3638@GVW1115EXC.americas.hpqcorp.net> <20100531205547.GH5334@quack.suse.cz> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F495C3DCB@GVW1115EXC.americas.hpqcorp.net> <20100601102240.GA4275@quack.suse.cz> <BA8A2107B0FD8A48AEB0405BDC36CE4F3F4A113B66@GVW1115EXC.americas.hpqcorp.net> <EE6E2E73-39B6-4D90-B2E2-3BA2C1DD4E91@mit.edu>
Reply-To: Theodore Tso <tytso@MIT.EDU>, 582275@bugs.debian.org
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-rc=glddbr-debian-bugs-rc=gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.582275.B582275.12768603303776@bugs.debian.org>
In-Reply-To: <EE6E2E73-39B6-4D90-B2E2-3BA2C1DD4E91@mit.edu>
List-Post: <mailto:debian-bugs-rc@lists.debian.org>
List-Help: <mailto:debian-bugs-rc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-rc-request@lists.debian.org?subject=unsubscribe>
To: Theodore Tso <tytso@mit.edu>
Cc: "Buehl, Reiner" <reiner.buehl@hp.com>, Jan Kara <jack@suse.cz>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "582275@bugs.debian.org" <582275@bugs.debian.org>
List-Id: linux-ide@vger.kernel.org


On Jun 18, 2010, at 7:09 AM, Theodore Tso wrote:
>=20
> It could be an e2fsck bug, or it could be a hardware issue.  In my =
experience, every time
> I've tried digging into problems with e2fsck -fy not fixing all =
problems in a single
> pass, it's been a hardware problem.  That being said, multiply claimed =
blocks is
> something that isn't exercised that much, so it's *possible* that it =
is an e2fsck bug.
>=20
> I really would need a reproducible test case before I could do =
anything though.

And reviewing the thread, the fact that you are reliably getting =
directory corruption
every single time you're booting, and the reliability of the hardware =
has been=20
called into question (forgive me for being a little suspicious of people =
trying
to do reliable storage using IDE devices).

-- Ted
