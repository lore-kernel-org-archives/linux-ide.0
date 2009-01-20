From: Diego Calleja <diegocg@gmail.com>
Subject: Re: Faulty seagate drives, are going to be blacklisted?
Date: Tue, 20 Jan 2009 16:30:28 +0100
Message-ID: <20090120163028.63efeb1a@diego-desktop>
References: <20090120002923.065f24ca@diego-desktop>
	<85346.1232422345@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760901AbZATPjW@vger.kernel.org>
In-Reply-To: <85346.1232422345@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

El Mon, 19 Jan 2009 22:32:25 -0500, Valdis.Kletnieks@vt.edu escribi=C3=B3=
:

> The $64 question is, of course: What exactly should the operating sys=
tem
> *do* if it detects one of these drives?  Prohibit it from bricking la=
ter
> by essentially bricking it *now*?   What if the drive already has a l=
ot of
> production data on it?

Yeah, that's why I asked. Now that I think about it, it should probably=
 be
the HAL people who should add one of those desktop "bubbles" warning th=
e
users about the possible failure (they already do it for faulty batteri=
es)
